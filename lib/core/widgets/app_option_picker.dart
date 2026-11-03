import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/assistje_tokens.dart';
import 'app_card.dart';
import 'app_sheet.dart';
import 'haptics.dart';

/// Eén keuze in een [AppOptionPicker].
class AppPickerOption<T> {
  const AppPickerOption({
    required this.value,
    required this.label,
    required this.key,
  });

  final T value;
  final String label;

  /// Key van de rij in de sheet.
  final Key key;
}

/// Een kaartknop met de huidige keuze en een pijltje; opent een sheet met
/// alle keuzes (vinkje bij de huidige). Vervangt een horizontaal scrollende
/// rij pills: alles in één oogopslag, groot tikvlak, niets verstopt.
class AppOptionPicker<T> extends StatelessWidget {
  const AppOptionPicker({
    super.key,
    required this.icon,
    required this.buttonLabel,
    required this.sheetTitle,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.enabled = true,
  });

  final IconData icon;
  final String buttonLabel;
  final String sheetTitle;
  final List<AppPickerOption<T>> options;
  final T? selected;
  final ValueChanged<T> onSelected;
  final bool enabled;

  Future<void> _open(BuildContext context) async {
    unawaited(Haptics.light());
    final chosen = await showAppSheet<(T,)>(
      context: context,
      title: sheetTitle,
      scrollable: true,
      builder: (sheetContext) {
        final t = AssistjeTokens.of(sheetContext);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in options)
              ListTile(
                key: option.key,
                contentPadding: EdgeInsets.zero,
                selected: option.value == selected,
                title: Text(
                  option.label,
                  style: TextStyle(
                    fontWeight: option.value == selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: t.ink,
                  ),
                ),
                trailing: option.value == selected
                    ? Icon(PhosphorIconsBold.check, color: t.primary, size: 18)
                    : null,
                onTap: () => Navigator.of(sheetContext).pop((option.value,)),
              ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
    // Een record, zodat `null` een geldige keuze is (wegtikken geeft null).
    if (chosen != null && chosen.$1 != selected) onSelected(chosen.$1);
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      child: AppCard(
        // 12 pt boven/onder: samen ≥ 44 pt tikvlak.
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        onTap: enabled ? () => _open(context) : null,
        child: Row(
          children: [
            Icon(icon, size: 18, color: t.muted),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                buttonLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: t.ink,
                ),
              ),
            ),
            Icon(PhosphorIconsBold.caretDown, size: 14, color: t.muted),
          ],
        ),
      ),
    );
  }
}
