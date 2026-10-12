import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/presentation/widgets/duty_icons.dart';
import '../../data/models/settings_models.dart';

/// De diensttypes (`DutyTypesTab.tsx`): tik = wijzigen, prullenbak =
/// verwijderen. Nieuw via de knop in de kop van het scherm.
class SettingsDutyTypesTab extends StatelessWidget {
  const SettingsDutyTypesTab({
    super.key,
    required this.types,
    required this.readOnly,
    required this.onEdit,
    required this.onDelete,
    required this.onCreate,
  });

  final List<DutyTypeSetting> types;
  final bool readOnly;
  final ValueChanged<DutyTypeSetting> onEdit;
  final ValueChanged<DutyTypeSetting> onDelete;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    if (types.isEmpty) {
      return EmptyState(
        key: const ValueKey('settings-duty-empty'),
        icon: PhosphorIconsDuotone.broom,
        title: l10n.settingsDutyEmptyTitle,
        description: l10n.settingsDutyEmptyDescription,
        action: readOnly
            ? null
            : PrimaryButton(
                key: const ValueKey('settings-duty-empty-add'),
                label: l10n.settingsDutyNew,
                onPressed: onCreate,
              ),
      );
    }
    return AppCard(
      key: const ValueKey('settings-duty-list'),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < types.length; i++) ...[
            if (i > 0) Divider(height: 1, color: t.lineSoft),
            _DutyTypeTile(
              type: types[i],
              onTap: readOnly ? null : () => onEdit(types[i]),
              onDelete: readOnly ? null : () => onDelete(types[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _DutyTypeTile extends StatelessWidget {
  const _DutyTypeTile({
    required this.type,
    required this.onTap,
    required this.onDelete,
  });

  final DutyTypeSetting type;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;

    Widget badge(String text, {Color? bg, Color? fg}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg ?? t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: fg ?? t.inkSoft,
        ),
      ),
    );

    return InkWell(
      key: ValueKey('settings-duty-${type.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: t.raised,
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              ),
              child: PhosphorIcon(
                dutyIconFor(type.icon, type.slug),
                size: 20,
                color: t.inkSoft,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: t.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      badge(switch (type.mode) {
                        DutyMode.individual => l10n.settingsDutyBadgeIndividual,
                        DutyMode.multi => l10n.settingsDutyBadgeMulti,
                        DutyMode.group => l10n.settingsDutyBadgeGroup,
                      }),
                      badge(
                        type.scope == DutyScope.match
                            ? l10n.settingsDutyBadgeMatch
                            : l10n.settingsDutyBadgeFree,
                      ),
                      if (type.autoRotate)
                        badge(
                          l10n.settingsDutyBadgeAuto,
                          bg: dark
                              ? StatusColors.emerald500.withValues(alpha: 0.15)
                              : StatusColors.emerald50,
                          fg: dark
                              ? StatusColors.emerald400
                              : StatusColors.emerald700,
                        ),
                      if (type.mode == DutyMode.individual &&
                          type.onUnavailable == DutyOnUnavailable.notify)
                        badge(
                          l10n.settingsDutyBadgeNotify,
                          bg: dark
                              ? const Color(0x26F59E0B)
                              : StatusColors.amber50,
                          fg: dark
                              ? StatusColors.amber400
                              : StatusColors.amber700,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              IconButton(
                key: ValueKey('settings-duty-delete-${type.id}'),
                tooltip: l10n.settingsRemove,
                onPressed: onDelete,
                icon: const PhosphorIcon(
                  PhosphorIconsBold.trash,
                  size: 18,
                  color: StatusColors.red500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
