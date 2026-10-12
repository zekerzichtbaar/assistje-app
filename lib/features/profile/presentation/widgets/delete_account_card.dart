import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/profile_controller.dart';
import 'profile_ui.dart';

/// "Verwijder profiel": klapt open naar een rood vak waarin je
/// [deleteAccountConfirmWord] typt. [onDelete] geeft de fout terug of `null`
/// (dan logt de controller al uit).
class DeleteAccountCard extends StatefulWidget {
  const DeleteAccountCard({super.key, required this.onDelete});

  final Future<Object?> Function(String confirm) onDelete;

  @override
  State<DeleteAccountCard> createState() => _DeleteAccountCardState();
}

class _DeleteAccountCardState extends State<DeleteAccountCard> {
  final _confirm = TextEditingController();
  bool _open = false;
  bool _busy = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _confirm.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  bool get _matches =>
      _confirm.text.trim().toUpperCase() == deleteAccountConfirmWord;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onDelete(deleteAccountConfirmWord);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = error;
    });
    if (error != null && profileFieldError(error, 'confirm') == null) {
      showProfileError(context, l10n.profileDeleteFailed, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      key: const ValueKey('profile-delete'),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        child: !_open
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCardHeader(
                    title: l10n.profileDeleteTitle,
                    body: l10n.profileDeleteBody,
                  ),
                  const SizedBox(height: 12),
                  ProfileDangerButton(
                    key: const ValueKey('profile-delete-open'),
                    label: l10n.profileDeleteButton,
                    icon: const Icon(PhosphorIconsRegular.trash, size: 14),
                    onPressed: () {
                      unawaited(Haptics.light());
                      setState(() => _open = true);
                    },
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: dark ? const Color(0x26EF4444) : StatusColors.red50,
                  borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
                  border: Border.all(
                    color: dark
                        ? const Color(0x4DEF4444)
                        : const Color(0xFFFECACA),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.profileDeleteConfirmBody(deleteAccountConfirmWord),
                      style: TextStyle(
                        fontSize: 14,
                        color: dark
                            ? const Color(0xFFFCA5A5)
                            : const Color(0xFF991B1B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('profile-delete-confirm'),
                      controller: _confirm,
                      autofocus: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: deleteAccountConfirmWord,
                        errorText: profileFieldError(_error, 'confirm'),
                        filled: true,
                        fillColor: t.surface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          key: const ValueKey('profile-delete-cancel'),
                          onPressed: _busy
                              ? null
                              : () => setState(() {
                                  _open = false;
                                  _error = null;
                                  _confirm.clear();
                                }),
                          child: Text(l10n.profileCancel),
                        ),
                        const SizedBox(width: 8),
                        ProfileDangerButton(
                          key: const ValueKey('profile-delete-submit'),
                          label: l10n.profileDelete,
                          loading: _busy,
                          onPressed: _matches && !_busy ? _submit : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
