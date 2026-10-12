import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/presentation/widgets/door_scaffold.dart';
import '../application/join_controller.dart';
import '../data/models/join_models.dart';
import 'widgets/join_door.dart';

final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

enum _Step { role, pick, confirm, name, email, sent }

/// Meedoen via de teamlink (`/meedoen/{token}`), zoals de PWA
/// (`Pages/Join/Index.tsx`): doe je mee of kijk je mee, wie ben je, en waar
/// bereiken we je. Een speler die zijn naam aantikt bevestigt eerst "ben jij
/// …?" (de server laat een claim zonder bevestiging niet door).
///
/// Afloop: nieuw account → meteen ingelogd in dit team; bestaand adres →
/// "check je mail"; al lid → naar dit team.
class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({required this.token, super.key});

  final String token;

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();

  _Step _step = _Step.role;
  JoinRole _role = JoinRole.player;

  /// De aangetikte naam, zolang hij nog bevestigd moet worden.
  JoinPlayer? _picked;

  /// De bevestigde claim.
  int? _playerId;

  /// Waar de bevestiging vandaan kwam: de lijst of het naamveld.
  _Step _claimFrom = _Step.pick;

  bool _busy = false;
  bool _entering = false;
  String? _error;
  String? _emailError;
  String? _sentEmail;

  /// Een ongeldige link die pas bij het verzenden bleek (`404`/`410`).
  String? _invalid;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  void _goHome() => context.go(AppRoutes.home);

  void _show(_Step step) => setState(() {
    _step = step;
    _error = null;
    _emailError = null;
  });

  void _chooseRole(JoinLink link, JoinRole role) {
    _role = role;
    _picked = null;
    _playerId = null;
    _show(
      role == JoinRole.player && link.players.isNotEmpty
          ? _Step.pick
          : _Step.name,
    );
  }

  void _pick(JoinPlayer player) {
    _claimFrom = _Step.pick;
    _picked = player;
    _show(_Step.confirm);
  }

  void _confirmClaim() {
    final picked = _picked;
    if (picked == null) return;
    _playerId = picked.id;
    _toEmail();
  }

  void _rejectClaim() {
    _picked = null;
    _playerId = null;
    // Tikte hij zijn naam in, dan betekent "nee": een tweede speler met
    // dezelfde naam. Terug naar de lijst zou een kringetje zijn.
    if (_claimFrom == _Step.name) {
      _toEmail();
    } else {
      _show(_Step.pick);
    }
  }

  static String _normalized(String value) =>
      value.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();

  /// Verder vanaf het naamveld: staat de naam onbezet in de selectie, dan
  /// dezelfde vraag als bij aantikken.
  void _afterName(JoinLink link) {
    if (_name.text.trim().length < 2) return;
    if (_role == JoinRole.player) {
      final typed = _normalized(_name.text);
      for (final player in link.players) {
        if (_normalized(player.name) == typed) {
          _claimFrom = _Step.name;
          _picked = player;
          _show(_Step.confirm);
          return;
        }
      }
    }
    _toEmail();
  }

  void _toEmail() {
    // Ingelogd: het eigen adres alvast invullen — dan komt dit team via de
    // bevestigingsmail bij het bestaande account.
    if (_email.text.isEmpty) {
      final own = ref.read(meProvider).value?.user.email;
      if (own != null) _email.text = own;
    }
    _show(_Step.email);
  }

  void _backFromEmail() {
    if (_playerId == null) {
      _show(_Step.name);
      return;
    }
    _picked = null;
    _playerId = null;
    _show(_claimFrom == _Step.name ? _Step.name : _Step.pick);
  }

  Future<void> _submit(JoinLink link, {bool withoutEmail = false}) async {
    final l10n = AppLocalizations.of(context);
    final email = withoutEmail ? '' : _email.text.trim();
    if (email.isNotEmpty && !_emailPattern.hasMatch(email)) {
      setState(() => _emailError = l10n.joinEmailInvalid);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _emailError = null;
    });
    try {
      final outcome = await ref
          .read(joinFlowProvider)
          .join(
            widget.token,
            link,
            role: _role,
            playerId: _playerId,
            name: _playerId == null ? _name.text : null,
            email: email,
          );
      if (!mounted) return;
      switch (outcome) {
        case JoinSignedIn():
          _goHome();
        case JoinConfirmationSent(:final email):
          setState(() {
            _sentEmail = email;
            _step = _Step.sent;
          });
      }
    } on ConflictException {
      await _enter(link);
    } on ValidationException catch (error) {
      if (!mounted) return;
      setState(() {
        _emailError = error.fieldError('email');
        _error =
            error.fieldError('name') ??
            error.fieldError('player_id') ??
            error.fieldError('claim_confirmed') ??
            error.fieldError('role') ??
            error.fieldError('device_name') ??
            (_emailError == null ? joinErrorText(l10n, error) : null);
      });
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        if (isInvalidLinkError(error)) {
          _invalid = joinErrorText(l10n, error);
        } else {
          _error = joinErrorText(l10n, error);
        }
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Al lid: naar dit team en de app in.
  Future<void> _enter(JoinLink link) async {
    if (_entering) return;
    _entering = true;
    try {
      await ref.read(joinFlowProvider).enterTeam(link.team.id);
    } on Object {
      // `/me` faalt: de router toont het startscherm met "opnieuw".
    }
    if (!mounted) return;
    // Pas terug naar de tabs als dit scherm helemaal open is: midden in de
    // overgang terug naar dezelfde shell botsen de GlobalKeys van de tabs.
    await _routeOpened();
    if (mounted) _goHome();
  }

  Future<void> _routeOpened() async {
    final animation = ModalRoute.of(context)?.animation;
    if (animation == null || animation.isCompleted) return;
    final opened = Completer<void>();
    void listener(AnimationStatus status) {
      if (status != AnimationStatus.forward && !opened.isCompleted) {
        opened.complete();
      }
    }

    animation.addStatusListener(listener);
    await opened.future;
    animation.removeStatusListener(listener);
  }

  Future<void> _codeLogin(String email) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).requestCode(email);
      if (!mounted) return;
      context.goNamed(
        AppRoutes.loginCodeName,
        queryParameters: {'email': email},
      );
    } on Object catch (error) {
      if (mounted) setState(() => _error = joinErrorText(l10n, error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final link = ref.watch(joinLinkProvider(widget.token));
    return KeyedSubtree(
      key: const ValueKey('join-screen'),
      child: JoinDoor(
        onClose: _goHome,
        child: switch (link) {
          AsyncData(:final value) => _content(l10n, value),
          AsyncError(:final error) => _loadError(l10n, error),
          _ => const JoinLoading(),
        },
      ),
    );
  }

  Widget _loadError(AppLocalizations l10n, Object error) {
    if (isInvalidLinkError(error)) return _invalidLink(l10n, error);
    return JoinMessage(
      key: const ValueKey('join-load-error'),
      title: l10n.joinInvalidTitle,
      message: joinErrorText(l10n, error),
      actionLabel: l10n.joinRetry,
      onAction: () => ref.invalidate(joinLinkProvider(widget.token)),
      secondaryLabel: l10n.joinToApp,
      onSecondary: _goHome,
    );
  }

  Widget _invalidLink(AppLocalizations l10n, Object? error) {
    return JoinMessage(
      key: const ValueKey('join-invalid'),
      title: l10n.joinInvalidTitle,
      message:
          _invalid ??
          (error is ApiException ? error.message : null) ??
          l10n.joinInvalidFallback,
      actionLabel: l10n.joinToApp,
      onAction: _goHome,
    );
  }

  Widget _content(AppLocalizations l10n, JoinLink link) {
    if (link.alreadyMember) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _enter(link));
      return const JoinLoading();
    }
    if (_invalid != null) return _invalidLink(l10n, null);
    final children = switch (_step) {
      _Step.role => _roleStep(l10n, link),
      _Step.pick => _pickStep(l10n, link),
      _Step.confirm => _confirmStep(l10n),
      _Step.name => _nameStep(l10n, link),
      _Step.email => _emailStep(l10n, link),
      _Step.sent => _sentStep(l10n, link),
    };
    return Column(
      key: ValueKey('join-step-${_step.name}'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  List<Widget> _heading(String title, String subtitle) => [
    DoorHeadline(title),
    const SizedBox(height: 12),
    DoorSubtitle(subtitle),
    const SizedBox(height: 28),
  ];

  List<Widget> _errorBox() => [
    if (_error != null) ...[DoorError(_error!), const SizedBox(height: 16)],
  ];

  List<Widget> _roleStep(AppLocalizations l10n, JoinLink link) => [
    ..._heading(l10n.joinWelcome(link.team.name), l10n.joinRoleQuestion),
    DoorButton(
      key: const Key('join-role-player'),
      label: l10n.joinRolePlayer,
      onPressed: () => _chooseRole(link, JoinRole.player),
    ),
    const SizedBox(height: 12),
    DoorPanel(
      key: const Key('join-role-spectator'),
      onTap: () => _chooseRole(link, JoinRole.spectator),
      child: Text(l10n.joinRoleSpectator, textAlign: TextAlign.center),
    ),
    const SizedBox(height: 20),
    DoorFootnote(l10n.joinRoleFootnote),
  ];

  List<Widget> _pickStep(AppLocalizations l10n, JoinLink link) => [
    ..._heading(l10n.joinPickTitle, l10n.joinPickSubtitle),
    for (final player in link.players) ...[
      DoorPanel(
        key: ValueKey('join-player-${player.id}'),
        onTap: () => _pick(player),
        child: Row(
          children: [
            if (player.shirtNumber != null)
              SizedBox(
                width: 28,
                child: Text(
                  '${player.shirtNumber}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0x800C120D),
                  ),
                ),
              ),
            Expanded(child: Text(player.name)),
          ],
        ),
      ),
      const SizedBox(height: 8),
    ],
    ..._errorBox(),
    DoorLinkButton(
      key: const Key('join-not-listed'),
      label: l10n.joinPickNotListed,
      onPressed: () => _show(_Step.name),
    ),
    DoorLinkButton(
      key: const Key('join-back'),
      label: l10n.joinBack,
      onPressed: () => _show(_Step.role),
    ),
  ];

  List<Widget> _confirmStep(AppLocalizations l10n) {
    final picked = _picked!;
    final number = picked.shirtNumber;
    return [
      ..._heading(
        l10n.joinClaimTitle(picked.name),
        number == null ? l10n.joinClaimNoShirt : l10n.joinClaimShirt(number),
      ),
      DoorButton(
        key: const Key('join-claim-yes'),
        label: l10n.joinClaimYes,
        onPressed: _confirmClaim,
      ),
      const SizedBox(height: 8),
      DoorLinkButton(
        key: const Key('join-claim-no'),
        label: l10n.joinClaimNo,
        onPressed: _rejectClaim,
      ),
    ];
  }

  List<Widget> _nameStep(AppLocalizations l10n, JoinLink link) => [
    ..._heading(
      l10n.joinNameTitle,
      _role == JoinRole.player
          ? l10n.joinNameSubtitlePlayer
          : l10n.joinNameSubtitleSpectator,
    ),
    TextField(
      key: const Key('join-name'),
      controller: _name,
      autofocus: true,
      maxLength: 120,
      textCapitalization: TextCapitalization.words,
      autofillHints: const [AutofillHints.name],
      textInputAction: TextInputAction.next,
      onChanged: (_) => setState(() {}),
      onSubmitted: (_) => _afterName(link),
      style: const TextStyle(fontSize: 17, color: DoorColors.ink),
      decoration: doorInputDecoration(label: l10n.joinNameHint),
    ),
    const SizedBox(height: 16),
    ..._errorBox(),
    DoorButton(
      key: const Key('join-next'),
      label: l10n.joinNext,
      onPressed: _name.text.trim().length > 1 ? () => _afterName(link) : null,
    ),
    const SizedBox(height: 8),
    DoorLinkButton(
      key: const Key('join-back'),
      label: l10n.joinBack,
      onPressed: () => _show(
        _role == JoinRole.player && link.players.isNotEmpty
            ? _Step.pick
            : _Step.role,
      ),
    ),
  ];

  List<Widget> _emailStep(AppLocalizations l10n, JoinLink link) => [
    ..._heading(l10n.joinEmailTitle, l10n.joinEmailSubtitle),
    TextField(
      key: const Key('join-email'),
      controller: _email,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      autocorrect: false,
      textInputAction: TextInputAction.send,
      onSubmitted: (_) => _submit(link),
      style: const TextStyle(fontSize: 17, color: DoorColors.ink),
      decoration: doorInputDecoration(
        label: l10n.joinEmailHint,
      ).copyWith(errorText: _emailError, errorMaxLines: 3),
    ),
    const SizedBox(height: 16),
    ..._errorBox(),
    DoorButton(
      key: const Key('join-submit'),
      label: l10n.joinSubmit,
      busy: _busy,
      onPressed: () => _submit(link),
    ),
    const SizedBox(height: 8),
    DoorLinkButton(
      key: const Key('join-skip'),
      label: l10n.joinSkip,
      onPressed: _busy ? null : () => _submit(link, withoutEmail: true),
    ),
    DoorLinkButton(
      key: const Key('join-back'),
      label: l10n.joinBack,
      onPressed: _busy ? null : _backFromEmail,
    ),
    const SizedBox(height: 12),
    DoorFootnote(l10n.joinEmailFootnote),
  ];

  List<Widget> _sentStep(AppLocalizations l10n, JoinLink link) {
    final email = _sentEmail ?? '';
    final signedOut = ref.watch(authControllerProvider) != AuthStatus.signedIn;
    return [
      ..._heading(l10n.joinSentTitle, l10n.joinSentSubtitle(link.team.name)),
      DoorPanel(
        key: const Key('join-sent-email'),
        child: Text(email, textAlign: TextAlign.center),
      ),
      const SizedBox(height: 20),
      ..._errorBox(),
      if (signedOut && email.isNotEmpty) ...[
        DoorButton(
          key: const Key('join-code-login'),
          label: l10n.joinSentCodeLogin,
          busy: _busy,
          onPressed: () => _codeLogin(email),
        ),
        const SizedBox(height: 20),
      ],
      DoorFootnote(l10n.joinSentFootnote),
    ];
  }
}
