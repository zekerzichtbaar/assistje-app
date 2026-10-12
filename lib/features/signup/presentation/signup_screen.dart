import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/presentation/widgets/door_scaffold.dart';
import '../../join/presentation/widgets/join_door.dart';
import '../application/signup_controller.dart';
import '../data/models/signup_models.dart';
import '../data/signup_logo_picker.dart';
import '../data/signup_repository.dart';
import 'widgets/signup_club_step.dart';
import 'widgets/signup_other_sport.dart';
import 'widgets/signup_results.dart';
import 'widgets/signup_training_step.dart';
import 'widgets/signup_widgets.dart';

/// Zelf een team aanmelden (`/aanmelden[?sport=]`), zoals de PWA
/// (`Pages/Signup/Index.tsx`): één vraag per scherm — sport, club, ploeg,
/// wie je bent, trainingen en bij een feed-sport het programma. Daarna
/// "check je mail" ([SignupSentView]); een sport die we niet doen wordt een
/// aanvraag ([SignupRequestedView]).
///
/// Publiek: uitgelogd én ingelogd. Er komt nooit een token terug; uitgelogd
/// biedt het eindscherm een inlogcode aan.
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({this.sport, super.key});

  /// De sport uit de link (`?sport=hockey`), of `null`.
  final String? sport;

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _clubName = TextEditingController();
  final _designation = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _feed = TextEditingController();

  /// `null` = de eerste stap van de flow.
  SignupStep? _step;
  String? _sport;
  bool _sportApplied = false;
  SignupClub? _club;
  bool _manualClub = false;
  PickedSignupLogo? _logo;
  String? _logoError;
  List<SignupTraining> _trainings = const [SignupTraining(weekday: 2)];
  bool _duplicateOk = false;

  /// Het elftal dat er al staat (`GET /signup/existing`).
  SignupTeam? _taken;
  bool _checking = false;
  bool _askingOther = false;
  bool _busy = false;
  String? _error;
  Map<String, List<String>> _errors = const {};

  SignupSent? _sent;
  SignupRequested? _requested;

  @override
  void dispose() {
    _clubName.dispose();
    _designation.dispose();
    _name.dispose();
    _email.dispose();
    _feed.dispose();
    super.dispose();
  }

  String get _effectiveSport => widget.sport?.trim() ?? '';

  String? _fieldError(String field) {
    final messages = _errors[field];
    return messages == null || messages.isEmpty ? null : messages.first;
  }

  String? get _trainingsError {
    final direct = _fieldError('trainings');
    if (direct != null) return direct;
    for (final entry in _errors.entries) {
      if (entry.key.startsWith('trainings.') && entry.value.isNotEmpty) {
        return entry.value.first;
      }
    }
    return null;
  }

  List<SignupStep> _steps(SignupOptions options) => signupSteps(
    sportFromLink: options.sport != null,
    chosen: options.sportFor(_sport),
  );

  SignupStep _current(List<SignupStep> steps) {
    final step = _step;
    return step != null && steps.contains(step) ? step : steps.first;
  }

  void _show(SignupStep step) => setState(() {
    _step = step;
    _error = null;
  });

  void _go(List<SignupStep> steps, int delta) {
    final next = steps.indexOf(_current(steps)) + delta;
    if (next >= 0 && next < steps.length) _show(steps[next]);
  }

  void _close() => context.go(AppRoutes.home);

  void _back(List<SignupStep> steps) {
    if (_askingOther) {
      setState(() => _askingOther = false);
      return;
    }
    if (steps.indexOf(_current(steps)) > 0) {
      _go(steps, -1);
    } else {
      _close();
    }
  }

  // ── Stappen ────────────────────────────────────────────────────────────

  void _chooseSport(SignupSport sport) {
    setState(() {
      if (_sport != sport.value) {
        // Een club en een feed horen bij de vorige sport.
        _club = null;
        _clubName.clear();
        _manualClub = false;
        _feed.clear();
      }
      _sport = sport.value;
      _step = SignupStep.club;
      _error = null;
    });
  }

  Future<void> _pickLogo(SignupLimits limits) async {
    final l10n = AppLocalizations.of(context);
    final picked = await ref.read(signupLogoPickerProvider).pick();
    if (picked == null || !mounted) return;
    final fits = picked.fits(
      mimetypes: limits.logoMimetypes,
      maxKb: limits.logoMaxKb,
    );
    setState(() {
      if (fits) {
        _logo = picked;
        _logoError = null;
      } else {
        _logoError = l10n.signupLogoInvalid((limits.logoMaxKb / 1024).ceil());
      }
    });
  }

  Future<void> _afterTeam(List<SignupStep> steps) async {
    final club = _club;
    if (club == null || _duplicateOk) {
      _go(steps, 1);
      return;
    }
    setState(() => _checking = true);
    final found = await ref
        .read(signupFlowProvider)
        .findExisting(
          clubId: club.id,
          sport: _sport ?? '',
          designation: _designation.text,
        );
    if (!mounted) return;
    setState(() {
      _checking = false;
      _taken = found;
    });
    if (found == null) _go(steps, 1);
  }

  void _clearDuplicate() {
    _taken = null;
    _errors = {
      for (final e in _errors.entries)
        if (e.key != 'duplicate') e.key: e.value,
    };
  }

  Future<void> _submit(List<SignupStep> steps) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final sent = await ref
          .read(signupFlowProvider)
          .submit(
            SignupDraft(
              sport: _sport ?? '',
              clubId: _club?.id,
              clubName: _manualClub ? _clubName.text : null,
              designation: _designation.text,
              name: _name.text,
              email: _email.text,
              trainings: _trainings,
              scheduleFeedUrl: steps.contains(SignupStep.programme)
                  ? _feed.text
                  : null,
              logo: _manualClub ? _logo : null,
              duplicateOk: _duplicateOk,
            ),
          );
      if (!mounted) return;
      if (ref.read(authControllerProvider) == AuthStatus.signedIn) {
        ref.read(signupFlowProvider).refreshMe();
      }
      setState(() {
        _errors = const {};
        _sent = sent;
      });
    } on ValidationException catch (error) {
      if (!mounted) return;
      setState(() {
        _errors = error.errors;
        // Terug naar de eerste stap met een fout; anders gebeurt er
        // zichtbaar niets onder de knop.
        for (final step in steps) {
          if (_errors.keys.any((field) => signupStepOf(field) == step)) {
            _step = step;
            break;
          }
        }
        if (_errors.isEmpty ||
            _errors.keys.every((field) => signupStepOf(field) == null)) {
          _error = signupErrorText(l10n, error);
        }
      });
    } on Object catch (error) {
      if (mounted) setState(() => _error = signupErrorText(l10n, error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // ── Opbouw ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = ref.watch(signupOptionsProvider(_effectiveSport));
    return KeyedSubtree(
      key: const ValueKey('signup-screen'),
      child: switch (options) {
        AsyncData(:final value) => _loaded(l10n, value),
        AsyncError(:final error) => JoinDoor(
          onClose: _close,
          child: JoinMessage(
            key: const ValueKey('signup-load-error'),
            title: l10n.signupLoadTitle,
            message: signupErrorText(l10n, error),
            actionLabel: l10n.signupRetry,
            onAction: () =>
                ref.invalidate(signupOptionsProvider(_effectiveSport)),
            secondaryLabel: l10n.signupToApp,
            onSecondary: _close,
          ),
        ),
        _ => JoinDoor(onClose: _close, child: const JoinLoading()),
      },
    );
  }

  Widget _loaded(AppLocalizations l10n, SignupOptions options) {
    if (!_sportApplied) {
      _sportApplied = true;
      _sport = options.sport;
    }
    final sent = _sent;
    if (sent != null) {
      return JoinDoor(
        onClose: _close,
        child: SignupSentView(sent: sent),
      );
    }
    final requested = _requested;
    if (requested != null) {
      return JoinDoor(
        onClose: _close,
        child: SignupRequestedView(requested: requested, onClose: _close),
      );
    }

    final steps = _steps(options);
    final step = _current(steps);
    final index = steps.indexOf(step);
    final first = index == 0 && !_askingOther;

    return DoorScaffold(
      leading: IconButton(
        key: Key(first ? 'signup-close' : 'signup-back'),
        tooltip: first ? l10n.signupClose : l10n.signupBack,
        color: DoorColors.ink,
        icon: Icon(first ? Icons.close_rounded : Icons.arrow_back_rounded),
        onPressed: () => _back(steps),
      ),
      child: _askingOther
          ? SignupOtherSport(
              sportLabels: [for (final s in options.sports) s.label],
              onRequested: (requested) =>
                  setState(() => _requested = requested),
            )
          : Column(
              key: ValueKey('signup-step-${step.name}'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SignupProgress(step: index + 1, total: steps.length),
                _stepBody(l10n, options, steps, step),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  DoorError(_error!),
                ],
                const SizedBox(height: 20),
                DoorFootnote(_footnote(l10n, step)),
              ],
            ),
    );
  }

  String _footnote(AppLocalizations l10n, SignupStep step) => switch (step) {
    SignupStep.sport => l10n.signupFootnoteSport,
    SignupStep.club || SignupStep.team => l10n.signupFootnoteAddress,
    SignupStep.programme => l10n.signupFootnoteProgramme,
    _ => l10n.signupFootnoteLater,
  };

  Widget _stepBody(
    AppLocalizations l10n,
    SignupOptions options,
    List<SignupStep> steps,
    SignupStep step,
  ) {
    final chosen = options.sportFor(_sport);
    return switch (step) {
      SignupStep.sport => _sportStep(l10n, options),
      SignupStep.club => SignupClubStep(
        key: ValueKey('signup-club-$_sport'),
        sport: _sport ?? '',
        club: _club,
        manual: _manualClub,
        clubName: _clubName,
        minChars: options.limits.clubSearchMinChars,
        error: _fieldError('club_name') ?? _fieldError('club_id'),
        logo: _logo,
        logoError: _logoError ?? _fieldError('logo'),
        onPick: (club) => setState(() {
          _club = club;
          _clubName.text = club?.name ?? '';
          // Een club uit de lijst neemt zijn eigen wapen mee.
          _logo = null;
          _logoError = null;
        }),
        onManual: (manual, term) => setState(() {
          _manualClub = manual;
          _club = null;
          _clubName.text = term;
          if (!manual) _logo = null;
        }),
        onNext: () => _go(steps, 1),
        onPickLogo: () => _pickLogo(options.limits),
        onRemoveLogo: () => setState(() => _logo = null),
      ),
      SignupStep.team => _teamStep(l10n, chosen, steps),
      SignupStep.you => _youStep(l10n, steps),
      SignupStep.trainings => SignupTrainingStep(
        trainings: _trainings,
        maxTrainings: options.limits.trainingsMax,
        onChanged: (slots) => setState(() => _trainings = slots),
        error: _trainingsError,
        busy: _busy,
        buttonLabel: steps.contains(SignupStep.programme)
            ? l10n.signupNext
            : l10n.signupSubmit,
        onContinue: steps.contains(SignupStep.programme)
            ? () => _go(steps, 1)
            : () => _submit(steps),
      ),
      SignupStep.programme => _programmeStep(l10n, chosen, steps),
    };
  }

  Widget _sportStep(AppLocalizations l10n, SignupOptions options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: l10n.signupSportTitle,
          subtitle: l10n.signupSportSubtitle,
        ),
        for (final sport in options.sports) ...[
          DoorPanel(
            key: ValueKey('signup-sport-${sport.value}'),
            onTap: () => _chooseSport(sport),
            child: Text(
              sport.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17),
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (_fieldError('sport') != null) ...[
          const SizedBox(height: 4),
          DoorError(_fieldError('sport')!),
        ],
        const SizedBox(height: 4),
        DoorLinkButton(
          key: const Key('signup-other-sport-link'),
          label: l10n.signupOtherSportLink,
          onPressed: () => setState(() => _askingOther = true),
        ),
      ],
    );
  }

  Widget _teamStep(
    AppLocalizations l10n,
    SignupSport? chosen,
    List<SignupStep> steps,
  ) {
    final duplicate = _fieldError('duplicate');
    final taken = _taken;
    final clubLabel = _club?.name ?? _clubName.text.trim();
    if ((taken != null || duplicate != null) && !_duplicateOk) {
      return Column(
        key: const ValueKey('signup-taken'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SignupHeading(
            eyebrow: clubLabel,
            title: taken != null
                ? l10n.signupTakenTitle(taken.name)
                : l10n.signupTakenFallbackTitle,
            subtitle: taken != null ? l10n.signupTakenSubtitle : duplicate,
          ),
          if (taken != null) ...[
            DoorButton(
              key: const Key('signup-taken-login'),
              label: l10n.signupTakenLogin(taken.name),
              onPressed: () => context.go(AppRoutes.login),
            ),
            const SizedBox(height: 8),
          ],
          DoorLinkButton(
            key: const Key('signup-taken-create'),
            label: l10n.signupTakenCreate,
            onPressed: () {
              setState(() {
                _clearDuplicate();
                _duplicateOk = true;
              });
              _go(steps, 1);
            },
          ),
          DoorLinkButton(
            key: const Key('signup-taken-other'),
            label: l10n.signupTakenOther,
            onPressed: () => setState(_clearDuplicate),
          ),
        ],
      );
    }
    final ready = _designation.text.trim().isNotEmpty;
    final designation = chosen?.designation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          eyebrow: clubLabel,
          title: designation?.question ?? l10n.signupTeamFallbackTitle,
          subtitle: designation?.hint,
        ),
        SignupField(
          key: const Key('signup-designation'),
          controller: _designation,
          label: designation?.example ?? '',
          autofocus: true,
          maxLength: 40,
          error: _fieldError('designation'),
          onChanged: (_) => setState(() => _duplicateOk = false),
          onSubmitted: (_) {
            if (ready && !_checking) _afterTeam(steps);
          },
        ),
        const SizedBox(height: 20),
        DoorButton(
          key: const Key('signup-next'),
          label: l10n.signupNext,
          busy: _checking,
          onPressed: ready ? () => _afterTeam(steps) : null,
        ),
      ],
    );
  }

  Widget _youStep(AppLocalizations l10n, List<SignupStep> steps) {
    final emailText = _email.text.trim();
    final ready =
        _name.text.trim().length > 1 && signupEmailPattern.hasMatch(emailText);
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SignupHeading(
            title: l10n.signupYouTitle,
            subtitle: l10n.signupYouSubtitle,
          ),
          SignupField(
            key: const Key('signup-name'),
            controller: _name,
            label: l10n.signupNameHint,
            autofocus: true,
            maxLength: 120,
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.name],
            textInputAction: TextInputAction.next,
            error: _fieldError('name'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          SignupField(
            key: const Key('signup-email'),
            controller: _email,
            label: l10n.signupEmailHint,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            autocorrect: false,
            maxLength: 255,
            error:
                _fieldError('email') ??
                (emailText.contains('@') &&
                        emailText.length > 5 &&
                        !signupEmailPattern.hasMatch(emailText)
                    ? l10n.signupEmailInvalid
                    : null),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) {
              if (ready) _go(steps, 1);
            },
          ),
          const SizedBox(height: 20),
          DoorButton(
            key: const Key('signup-next'),
            label: l10n.signupNext,
            onPressed: ready ? () => _go(steps, 1) : null,
          ),
        ],
      ),
    );
  }

  Widget _programmeStep(
    AppLocalizations l10n,
    SignupSport? chosen,
    List<SignupStep> steps,
  ) {
    final source = chosen?.federationImport;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(title: l10n.signupProgrammeTitle, subtitle: source?.hint),
        SignupField(
          key: const Key('signup-feed'),
          controller: _feed,
          label: source?.example ?? '',
          autofocus: true,
          autocorrect: false,
          keyboardType: TextInputType.url,
          error: _fieldError('schedule_feed_url'),
          onSubmitted: (_) {
            if (!_busy) _submit(steps);
          },
        ),
        const SizedBox(height: 20),
        DoorButton(
          key: const Key('signup-submit'),
          label: l10n.signupSubmit,
          busy: _busy,
          onPressed: () => _submit(steps),
        ),
      ],
    );
  }
}
