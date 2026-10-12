import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/profile_controller.dart';
import '../../data/avatar_picker.dart';
import '../../data/models/profile_models.dart';
import 'profile_ui.dart';

/// Het profielformulier (PWA: de eerste kaart van `Profile/Edit`): foto
/// (nieuw/verwijderen), e-mail (met wachtend adres), naam en geboortedatum.
class AccountCard extends ConsumerStatefulWidget {
  const AccountCard({super.key, required this.teamId, required this.account});

  final int teamId;
  final ProfileAccount account;

  @override
  ConsumerState<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends ConsumerState<AccountCard> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  String? _birthdate;
  Object? _error;
  String? _nameError;
  bool _saving = false;
  bool _avatarBusy = false;
  bool _resending = false;

  ProfileController get _controller =>
      ref.read(profileControllerProvider(widget.teamId).notifier);

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _reset();
  }

  @override
  void didUpdateWidget(covariant AccountCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final before = oldWidget.account;
    final after = widget.account;
    // Alleen de formuliervelden opnieuw vullen als de server iets anders zegt
    // (opslaan, verversen) — niet bij een nieuwe foto.
    if (before.name != after.name ||
        before.email != after.email ||
        before.pendingEmail != after.pendingEmail ||
        before.birthdate != after.birthdate) {
      _reset();
    }
  }

  void _reset() {
    final account = widget.account;
    _name.text = account.name;
    // Een adres dat op bevestiging wacht is wat hij invulde: dat tonen,
    // de regel eronder zegt wat er nog moet gebeuren (zoals de PWA).
    _email.text = account.email ?? account.pendingEmail ?? '';
    _birthdate = account.birthdate;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = l10n.profileNameRequired);
      unawaited(Haptics.error());
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _saving = true;
      _nameError = null;
      _error = null;
    });
    final email = _email.text.trim();
    final result = await _controller.updateAccount(
      name: name,
      email: email.isEmpty ? null : email,
      birthdate: _birthdate,
    );
    if (!mounted) return;
    setState(() {
      _saving = false;
      _error = result.error;
    });
    final error = result.error;
    if (error != null) {
      showProfileError(context, l10n.profileSaveFailed, error);
      return;
    }
    final sentTo = result.emailClaimSentTo;
    if (sentTo != null) {
      showProfileSuccess(
        context,
        l10n.profileEmailClaimTitle,
        body: l10n.profileEmailClaimBody(sentTo),
      );
    } else {
      showProfileSuccess(context, l10n.profileSaved);
    }
  }

  Future<void> _resend() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _resending = true);
    final error = await _controller.resendEmailClaim();
    if (!mounted) return;
    setState(() => _resending = false);
    if (error != null) {
      showProfileError(context, l10n.profileSaveFailed, error);
    } else {
      showProfileSuccess(context, l10n.profileEmailResent);
    }
  }

  Future<void> _pickBirthdate() async {
    unawaited(Haptics.selection());
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final current = parseProfileDate(_birthdate);
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime(today.year - 25, today.month),
      firstDate: DateTime(1900),
      lastDate: yesterday,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && mounted) {
      setState(() => _birthdate = formatProfileIsoDate(picked));
    }
  }

  Future<void> _newAvatar() async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final source = await showAppSheet<AvatarSource>(
      context: context,
      title: l10n.profileAvatarUpload,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            key: const ValueKey('profile-avatar-camera'),
            leading: const Icon(PhosphorIconsRegular.camera),
            title: Text(l10n.profileAvatarCamera),
            onTap: () => Navigator.of(context).pop(AvatarSource.camera),
          ),
          ListTile(
            key: const ValueKey('profile-avatar-gallery'),
            leading: const Icon(PhosphorIconsRegular.image),
            title: Text(l10n.profileAvatarGallery),
            onTap: () => Navigator.of(context).pop(AvatarSource.gallery),
          ),
        ],
      ),
    );
    if (source == null || !mounted) return;
    setState(() => _avatarBusy = true);
    final result = await _controller.pickAndUploadAvatar(source);
    if (!mounted) return;
    setState(() => _avatarBusy = false);
    if (result.cancelled) return;
    final error = result.error;
    if (error != null) {
      showProfileError(context, l10n.profileAvatarFailed, error);
    } else {
      showProfileSuccess(context, l10n.profileAvatarSaved);
    }
  }

  Future<void> _removeAvatar() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmProfileAction(
      context,
      question: l10n.profileAvatarRemoveConfirm,
      confirmLabel: l10n.profileDelete,
    );
    if (!ok || !mounted) return;
    setState(() => _avatarBusy = true);
    final error = await _controller.removeAvatar();
    if (!mounted) return;
    setState(() => _avatarBusy = false);
    if (error != null) {
      showProfileError(context, l10n.profileAvatarRemoveFailed, error);
    } else {
      showProfileSuccess(context, l10n.profileAvatarRemoved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final account = widget.account;
    final pending = account.pendingEmail;
    final birthdate = _birthdate;

    return AppCard(
      key: const ValueKey('profile-account'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Semantics(
                button: true,
                label: l10n.profileAvatarUpload,
                child: GestureDetector(
                  key: const ValueKey('profile-avatar'),
                  onTap: _avatarBusy ? null : _newAvatar,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppAvatar(
                        name: account.name,
                        imageUrl: account.avatarUrl,
                        size: 80,
                      ),
                      if (_avatarBusy)
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0x4D000000),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: SizedBox.square(
                              dimension: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SecondaryButton(
                      key: const ValueKey('profile-avatar-new'),
                      label: l10n.profileAvatarNew,
                      onPressed: _avatarBusy ? null : _newAvatar,
                    ),
                    if (account.avatarUrl != null)
                      SecondaryButton(
                        key: const ValueKey('profile-avatar-remove'),
                        label: l10n.profileDelete,
                        onPressed: _avatarBusy ? null : _removeAvatar,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _FieldLabel(l10n.profileFieldEmail),
          _FieldRow(
            icon: PhosphorIconsRegular.envelopeSimple,
            child: TextField(
              key: const ValueKey('profile-email'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: _bare(l10n.profileEmailPlaceholder),
            ),
          ),
          _FieldError(profileFieldError(_error, 'email')),
          if (pending != null) ...[
            const SizedBox(height: 6),
            Text(
              l10n.profileEmailPending(pending),
              key: const ValueKey('profile-email-pending'),
              style: const TextStyle(fontSize: 12, color: profileAmber600),
            ),
            if (account.email == null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  key: const ValueKey('profile-email-resend'),
                  onPressed: _resending ? null : _resend,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: t.ink,
                  ),
                  child: Text(l10n.profileEmailResend),
                ),
              ),
          ] else if (account.email == null) ...[
            const SizedBox(height: 6),
            Text(
              l10n.profileEmailMissing,
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ],
          const SizedBox(height: 16),
          _FieldLabel(l10n.profileFieldName),
          _FieldRow(
            icon: PhosphorIconsRegular.user,
            child: TextField(
              key: const ValueKey('profile-name'),
              controller: _name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              decoration: _bare(null),
            ),
          ),
          _FieldError(_nameError ?? profileFieldError(_error, 'name')),
          const SizedBox(height: 16),
          _FieldLabel(l10n.profileFieldBirthdate),
          _FieldRow(
            icon: PhosphorIconsRegular.cake,
            onTap: _pickBirthdate,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    birthdate == null
                        ? l10n.profileBirthdatePlaceholder
                        : formatProfileDate(birthdate),
                    key: const ValueKey('profile-birthdate'),
                    style: TextStyle(
                      fontSize: 16,
                      color: birthdate == null ? t.muted : t.ink,
                    ),
                  ),
                ),
                if (birthdate != null)
                  IconButton(
                    key: const ValueKey('profile-birthdate-clear'),
                    tooltip: l10n.profileBirthdateClear,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      PhosphorIconsRegular.x,
                      size: 16,
                      color: t.muted,
                    ),
                    onPressed: () => setState(() => _birthdate = null),
                  ),
              ],
            ),
          ),
          _FieldError(profileFieldError(_error, 'birthdate')),
          const SizedBox(height: 20),
          PrimaryButton(
            key: const ValueKey('profile-save'),
            label: l10n.profileSave,
            expand: true,
            loading: _saving,
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }

  static InputDecoration _bare(String? hint) => InputDecoration(
    isDense: true,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    filled: false,
    contentPadding: EdgeInsets.zero,
    hintText: hint,
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AssistjeTokens.of(context).inkSoft,
      ),
    ),
  );
}

/// `FieldRow` uit de PWA: icoon in de teamkleur + invoer, in een omrand vak.
class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.icon, required this.child, this.onTap});

  final IconData icon;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final row = Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        border: Border.all(color: t.line),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: t.primary),
          const SizedBox(width: 12),
          Expanded(child: child),
        ],
      ),
    );
    if (onTap == null) return row;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        child: row,
      ),
    );
  }
}

class _FieldError extends StatelessWidget {
  const _FieldError(this.message);

  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = message;
    if (text == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: StatusColors.red600),
      ),
    );
  }
}
