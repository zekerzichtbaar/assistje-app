import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/door_scaffold.dart';
import '../../../join/presentation/widgets/join_door.dart';
import '../../application/signup_controller.dart';
import '../../data/models/signup_models.dart';
import 'signup_widgets.dart';

/// Een sport die de app niet kent: geen omgeving maar een aanvraag
/// (`POST /signup/other-sport`).
class SignupOtherSport extends ConsumerStatefulWidget {
  const SignupOtherSport({
    required this.sportLabels,
    required this.onRequested,
    super.key,
  });

  /// De sporten die de app wél doet, voor de uitleg.
  final List<String> sportLabels;
  final ValueChanged<SignupRequested> onRequested;

  @override
  ConsumerState<SignupOtherSport> createState() => _SignupOtherSportState();
}

class _SignupOtherSportState extends ConsumerState<SignupOtherSport> {
  final _sport = TextEditingController();
  final _club = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();

  bool _busy = false;
  String? _error;
  Map<String, List<String>> _errors = const {};

  @override
  void dispose() {
    _sport.dispose();
    _club.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  bool get _ready =>
      _sport.text.trim().length > 1 &&
      _club.text.trim().length > 1 &&
      _name.text.trim().length > 1 &&
      signupEmailPattern.hasMatch(_email.text.trim());

  String? _field(String name) {
    final messages = _errors[name];
    return messages == null || messages.isEmpty ? null : messages.first;
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
      _errors = const {};
    });
    try {
      final requested = await ref
          .read(signupFlowProvider)
          .requestOtherSport(
            sport: _sport.text,
            clubName: _club.text,
            name: _name.text,
            email: _email.text,
          );
      if (mounted) widget.onRequested(requested);
    } on ValidationException catch (error) {
      if (!mounted) return;
      setState(() {
        _errors = error.errors;
        if (_errors.isEmpty) _error = signupErrorText(l10n, error);
      });
    } on Object catch (error) {
      if (mounted) setState(() => _error = signupErrorText(l10n, error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _sportsList(AppLocalizations l10n) {
    final labels = [for (final l in widget.sportLabels) l.toLowerCase()];
    if (labels.length < 2) return labels.join();
    return '${labels.sublist(0, labels.length - 1).join(', ')} '
        '${l10n.signupAnd} ${labels.last}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    void changed(String _) => setState(() {});
    return Column(
      key: const ValueKey('signup-other'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: l10n.signupOtherTitle,
          subtitle: widget.sportLabels.isEmpty
              ? l10n.signupOtherSubtitleGeneric
              : l10n.signupOtherSubtitle(_sportsList(l10n)),
        ),
        SignupField(
          key: const Key('signup-other-sport'),
          controller: _sport,
          label: l10n.signupOtherSportHint,
          autofocus: true,
          maxLength: 60,
          textCapitalization: TextCapitalization.sentences,
          error: _field('sport'),
          onChanged: changed,
        ),
        const SizedBox(height: 12),
        SignupField(
          key: const Key('signup-other-club'),
          controller: _club,
          label: l10n.signupClubNameHint,
          maxLength: 120,
          textCapitalization: TextCapitalization.words,
          error: _field('club_name'),
          onChanged: changed,
        ),
        const SizedBox(height: 12),
        SignupField(
          key: const Key('signup-other-name'),
          controller: _name,
          label: l10n.signupNameHint,
          maxLength: 120,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.name],
          error: _field('name'),
          onChanged: changed,
        ),
        const SizedBox(height: 12),
        SignupField(
          key: const Key('signup-other-email'),
          controller: _email,
          label: l10n.signupEmailHint,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          autocorrect: false,
          error: _field('email'),
          onChanged: changed,
        ),
        if (_error != null) ...[const SizedBox(height: 12), DoorError(_error!)],
        const SizedBox(height: 20),
        DoorButton(
          key: const Key('signup-other-submit'),
          label: l10n.signupOtherSubmit,
          busy: _busy,
          onPressed: _ready ? _submit : null,
        ),
        const SizedBox(height: 16),
        DoorFootnote(l10n.signupOtherFootnote),
      ],
    );
  }
}
