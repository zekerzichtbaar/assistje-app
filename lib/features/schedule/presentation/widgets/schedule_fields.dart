import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is (ook
/// de demo-403), anders een algemene melding.
String scheduleErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// Toont een fouttoast (met trilling).
void showScheduleError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: scheduleErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Toont een succestoast (met trilling).
void showScheduleSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging; `true` als bevestigd.
Future<bool> confirmSchedule(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          key: const ValueKey('schedule-confirm-back'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.scheduleConfirmBack),
        ),
        TextButton(
          key: const ValueKey('schedule-confirm-ok'),
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

/// Label boven een veld.
class ScheduleFieldLabel extends StatelessWidget {
  const ScheduleFieldLabel(this.text, {super.key});

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

/// Een veldfout onder een veld.
class ScheduleFieldError extends StatelessWidget {
  const ScheduleFieldError(this.text, {super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final text = this.text;
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

/// Een tikbaar veld (datum of tijd) met icoon, waarde of placeholder, en
/// optioneel een wisknop.
class SchedulePickerField extends StatelessWidget {
  const SchedulePickerField({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.placeholder,
    required this.onTap,
    this.onClear,
    this.clearLabel,
    this.error,
  });

  final String label;
  final IconData icon;
  final String? value;
  final String placeholder;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final String? clearLabel;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final value = this.value;
    final clear = onClear;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScheduleFieldLabel(label),
        Semantics(
          button: true,
          label: label,
          value: value,
          child: Material(
            color: t.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              side: BorderSide(
                color: error != null ? StatusColors.red600 : t.line,
              ),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  14,
                  value != null && clear != null ? 2 : 12,
                  value != null && clear != null ? 2 : 14,
                  value != null && clear != null ? 2 : 12,
                ),
                child: Row(
                  children: [
                    Icon(icon, size: 20, color: t.muted),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ExcludeSemantics(
                        child: Text(
                          value ?? placeholder,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: value == null ? t.muted : t.ink,
                          ),
                        ),
                      ),
                    ),
                    if (value != null && clear != null)
                      IconButton(
                        key: key is ValueKey<String>
                            ? ValueKey(
                                '${(key! as ValueKey<String>).value}-clear',
                              )
                            : null,
                        tooltip: clearLabel,
                        onPressed: clear,
                        icon: Icon(
                          PhosphorIconsRegular.x,
                          size: 16,
                          color: t.muted,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ScheduleFieldError(error),
      ],
    );
  }
}

/// Eén knop in een [ScheduleSegmented].
class ScheduleSegment<T> {
  const ScheduleSegment({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Knoppen naast elkaar waarvan er één aan staat (type, thuis/uit, soort).
/// Sleutel per knop: `<keyPrefix>-<value>`.
class ScheduleSegmented<T> extends StatelessWidget {
  const ScheduleSegmented({
    super.key,
    required this.keyPrefix,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.keyOf,
  });

  final String keyPrefix;
  final List<ScheduleSegment<T>> segments;
  final T selected;
  final ValueChanged<T>? onChanged;

  /// Hoe een waarde in de sleutel komt (standaard `toString()`).
  final String Function(T value)? keyOf;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Row(
      children: [
        for (final (index, segment) in segments.indexed) ...[
          if (index > 0) const SizedBox(width: 8),
          Expanded(
            child: _SegmentButton(
              key: ValueKey(
                '$keyPrefix-${keyOf?.call(segment.value) ?? segment.value}',
              ),
              label: segment.label,
              icon: segment.icon,
              active: segment.value == selected,
              tokens: t,
              onTap: onChanged == null
                  ? null
                  : () {
                      if (segment.value == selected) return;
                      Haptics.selection();
                      onChanged!(segment.value);
                    },
            ),
          ),
        ],
      ],
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    super.key,
    required this.label,
    required this.icon,
    required this.active,
    required this.tokens,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool active;
  final AssistjeTokens tokens;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = tokens;
    final fg = active ? t.primaryContrast : t.inkSoft;
    return Semantics(
      button: true,
      selected: active,
      child: Material(
        color: active ? t.primary : t.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          side: BorderSide(color: active ? Colors.transparent : t.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  PhosphorIcon(icon!, size: 18, color: fg),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
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

/// Een omrande kaart met icoon, titel, uitleg en schakelaar (wekelijks
/// herhalen, toeschouwers). [child] staat eronder als de schakelaar aan is.
class ScheduleToggleCard extends StatelessWidget {
  const ScheduleToggleCard({
    super.key,
    required this.switchKey,
    required this.icon,
    required this.title,
    required this.body,
    required this.value,
    required this.onChanged,
    this.child,
  });

  final Key switchKey;
  final IconData icon;
  final String title;
  final String body;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        border: Border.all(color: t.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: PhosphorIcon(icon, size: 20, color: t.muted),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: t.ink,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            body,
                            style: TextStyle(fontSize: 12, color: t.muted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Switch.adaptive(
                      key: switchKey,
                      value: value,
                      onChanged: onChanged == null
                          ? null
                          : (v) {
                              Haptics.selection();
                              onChanged!(v);
                            },
                    ),
                  ],
                ),
                if (value && child != null) ...[
                  const SizedBox(height: 16),
                  child!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
