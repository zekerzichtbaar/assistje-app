import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` (of de eerste
/// veldfout) als die er is, anders een algemene melding.
String settingsErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      ForbiddenException() => l10n.settingsReadOnlyForbidden,
      final ApiException e when e.errors.isNotEmpty =>
        e.errors.values.expand((m) => m).firstOrNull ?? l10n.errorGeneric,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De eerste veldfout voor een van [fields] bij een 422, anders `null`.
String? settingsFieldError(Object? error, List<String> fields) {
  if (error is! ValidationException) return null;
  for (final field in fields) {
    final message = error.fieldError(field);
    if (message != null) return message;
  }
  return null;
}

/// Fouttoast (met trilling).
void showSettingsError(BuildContext context, Object? error, {String? title}) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title ?? l10n.settingsSaveFailed,
    message: settingsErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showSettingsSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging — `true` als bevestigd. [destructive] kleurt de knop
/// rood.
Future<bool> confirmSettings(
  BuildContext context, {
  required String message,
  required String confirmLabel,
  String? title,
  bool destructive = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [
        TextButton(
          key: const ValueKey('settings-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.settingsCancel),
        ),
        TextButton(
          key: const ValueKey('settings-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: StatusColors.red600)
              : null,
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Kaart met een kopregel in hoofdletters (`CardTitle` in de PWA).
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: t.raised,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: t.muted,
                      ),
                    ),
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// Rij met titel, uitleg en schakelaar (`Toggle` in de PWA). [onChanged]
/// `null` = uitgeschakeld (alleen-lezen). Met [inset] in een grijs vlak
/// (een sub-instelling onder een functie).
class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.inset = false,
    this.switchKey,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool inset;
  final Key? switchKey;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: inset ? 14 : 15,
                  fontWeight: FontWeight.w500,
                  color: t.ink,
                ),
              ),
              if (subtitle != null && subtitle!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    subtitle!,
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch.adaptive(key: switchKey, value: value, onChanged: onChanged),
      ],
    );
    if (!inset) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: row,
      );
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: row,
    );
  }
}

/// Een melding in een grijs vlak (alleen-lezen, uitleg).
class SettingsNotice extends StatelessWidget {
  const SettingsNotice({
    super.key,
    required this.text,
    this.icon,
    this.title,
    this.warning = false,
  });

  final String text;
  final String? title;
  final IconData? icon;

  /// Amber in plaats van grijs.
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = warning
        ? (dark ? const Color(0x26F59E0B) : StatusColors.amber50)
        : t.raised;
    final fg = warning
        ? (dark ? StatusColors.amber200 : StatusColors.amber800)
        : t.inkSoft;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: fg),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: fg,
                      ),
                    ),
                  ),
                Text(text, style: TextStyle(fontSize: 13, color: fg)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Een keuze als kaartje met titel en uitleg (radio in de PWA).
class SettingsOptionTile extends StatelessWidget {
  const SettingsOptionTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.description,
  });

  final String title;
  final String? description;
  final bool selected;

  /// `null` = uitgeschakeld.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? t.primary.withValues(alpha: 0.08) : t.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          side: BorderSide(color: selected ? t.primary : t.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 18,
                  color: selected ? t.primary : t.muted,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                      if (description != null)
                        Text(
                          description!,
                          style: TextStyle(fontSize: 12, color: t.muted),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Een label boven een invoerveld.
class SettingsFieldLabel extends StatelessWidget {
  const SettingsFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          color: t.muted,
        ),
      ),
    );
  }
}

/// Kleine uitlegtekst onder een veld.
class SettingsHint extends StatelessWidget {
  const SettingsHint(this.text, {super.key, this.error = false});

  final String text;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: error ? 13 : 12,
          color: error ? StatusColors.red600 : t.muted,
        ),
      ),
    );
  }
}

/// Uren-keuze: vaste knoppen plus een eigen getal (`HourPicker`).
class HourPicker extends StatefulWidget {
  const HourPicker({
    super.key,
    required this.value,
    required this.presets,
    required this.max,
    required this.onChanged,
    required this.keyPrefix,
  });

  final int value;
  final List<int> presets;
  final int max;

  /// `null` = uitgeschakeld.
  final ValueChanged<int>? onChanged;
  final String keyPrefix;

  @override
  State<HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  late final TextEditingController _custom = TextEditingController(
    text: '${widget.value}',
  );

  @override
  void didUpdateWidget(HourPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value &&
        int.tryParse(_custom.text) != widget.value) {
      _custom.text = '${widget.value}';
    }
  }

  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  void _submitCustom(String text) {
    final n = int.tryParse(text.trim());
    if (n == null) return;
    final clamped = n.clamp(1, widget.max);
    if (clamped != n) _custom.text = '$clamped';
    if (clamped != widget.value) widget.onChanged?.call(clamped);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final enabled = widget.onChanged != null;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final h in widget.presets)
          AppPill(
            key: ValueKey('${widget.keyPrefix}-$h'),
            label: l10n.settingsHours(h),
            selected: widget.value == h,
            onTap: enabled ? () => widget.onChanged!(h) : null,
          ),
        Text(l10n.settingsOr, style: TextStyle(fontSize: 14, color: t.muted)),
        SizedBox(
          width: 72,
          child: TextField(
            key: ValueKey('${widget.keyPrefix}-custom'),
            controller: _custom,
            enabled: enabled,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
            onSubmitted: _submitCustom,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
              _submitCustom(_custom.text);
            },
          ),
        ),
        Text(
          l10n.settingsHourUnit,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      ],
    );
  }
}
