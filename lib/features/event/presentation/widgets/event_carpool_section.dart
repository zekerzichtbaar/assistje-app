import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/event_detail_models.dart';
import 'event_section_card.dart';

/// Wat iemand in de carpool-sheet kiest.
typedef CarpoolChoice = ({CarpoolMode mode, int seats});

/// Rijden naar een uitwedstrijd (`CarpoolSection.tsx`): wie vanaf de club
/// rijdt (met plekken) en wie rechtstreeks gaat, plus aanmelden/wijzigen
/// en weghalen.
class EventCarpoolSection extends StatelessWidget {
  const EventCarpoolSection({
    super.key,
    required this.offers,
    required this.onSave,
    required this.onRemove,
  });

  final List<CarpoolOffer> offers;
  final ValueChanged<CarpoolChoice> onSave;
  final VoidCallback onRemove;

  CarpoolOffer? get _mine {
    for (final o in offers) {
      if (o.isSelf) return o;
    }
    return null;
  }

  Future<void> _open(BuildContext context) async {
    final mine = _mine;
    final choice = await showCarpoolSheet(
      context,
      mode: mine?.mode ?? CarpoolMode.fromClub,
      seats: mine?.seats ?? 4,
    );
    if (choice != null) onSave(choice);
  }

  Future<void> _confirmRemove(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l10n.eventDetailCarpoolRemoveConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.eventDetailCancel),
          ),
          TextButton(
            key: const ValueKey('carpool-remove-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
            child: Text(l10n.eventDetailCarpoolRemoveYes),
          ),
        ],
      ),
    );
    if (ok ?? false) onRemove();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final fromClub = offers.where((o) => o.mode == CarpoolMode.fromClub);
    final direct = offers.where((o) => o.mode == CarpoolMode.direct);
    final mine = _mine;

    Widget heading(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          color: t.muted,
        ),
      ),
    );

    Widget row(CarpoolOffer o, {String? trailing}) => Padding(
      key: ValueKey('carpool-offer-${o.id}'),
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          AppAvatar(name: o.userName, imageUrl: o.avatarUrl, size: 32),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              o.userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: t.ink,
              ),
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: t.inkSoft,
              ),
            ),
        ],
      ),
    );

    return EventSectionCard(
      key: const ValueKey('event-carpool'),
      title: l10n.eventDetailCarpoolTitle,
      icon: PhosphorIconsDuotone.car,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (offers.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  l10n.eventDetailCarpoolEmpty,
                  key: const ValueKey('carpool-empty'),
                  style: TextStyle(fontSize: 14, color: t.muted),
                ),
              ),
            if (fromClub.isNotEmpty) ...[
              heading(l10n.eventDetailCarpoolFromClub),
              for (final o in fromClub)
                row(o, trailing: l10n.eventDetailCarpoolSeats(o.seats ?? 1)),
              const SizedBox(height: 8),
            ],
            if (direct.isNotEmpty) ...[
              heading(l10n.eventDetailCarpoolDirect),
              for (final o in direct) row(o),
              const SizedBox(height: 8),
            ],
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                PrimaryButton(
                  key: const ValueKey('carpool-open'),
                  label: mine == null
                      ? l10n.eventDetailCarpoolOffer
                      : l10n.eventDetailCarpoolEdit,
                  onPressed: () => _open(context),
                ),
                if (mine != null)
                  TextButton(
                    key: const ValueKey('carpool-remove'),
                    onPressed: () => _confirmRemove(context),
                    style: TextButton.styleFrom(foregroundColor: t.muted),
                    child: Text(l10n.eventDetailCarpoolRemove),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// De sheet "Hoe ga je naar de wedstrijd?". Geeft de keuze terug, of `null`
/// als hij weggeveegd is.
Future<CarpoolChoice?> showCarpoolSheet(
  BuildContext context, {
  required CarpoolMode mode,
  required int seats,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<CarpoolChoice>(
    context: context,
    title: l10n.eventDetailCarpoolSheetTitle,
    builder: (context) => _CarpoolForm(mode: mode, seats: seats),
  );
}

class _CarpoolForm extends StatefulWidget {
  const _CarpoolForm({required this.mode, required this.seats});

  final CarpoolMode mode;
  final int seats;

  @override
  State<_CarpoolForm> createState() => _CarpoolFormState();
}

class _CarpoolFormState extends State<_CarpoolForm> {
  static const int minSeats = 1;
  static const int maxSeats = 8;

  late CarpoolMode _mode = widget.mode;
  late int _seats = widget.seats.clamp(minSeats, maxSeats);

  void _setSeats(int value) {
    Haptics.selection();
    setState(() => _seats = value.clamp(minSeats, maxSeats));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);

    Widget option({
      required CarpoolMode value,
      required String title,
      Widget? extra,
    }) {
      final selected = _mode == value;
      return GestureDetector(
        key: ValueKey('carpool-mode-${value.name}'),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Haptics.selection();
          setState(() => _mode = value);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? t.primary : t.line,
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 20,
                color: selected ? t.primary : t.muted,
              ),
              const SizedBox(width: 12),
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
                    ?extra,
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        option(
          value: CarpoolMode.fromClub,
          title: l10n.eventDetailCarpoolModeFromClub,
          extra: _mode == CarpoolMode.fromClub
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.eventDetailCarpoolSeatsLabel,
                          style: TextStyle(fontSize: 12, color: t.inkSoft),
                        ),
                      ),
                      IconButton(
                        key: const ValueKey('carpool-seats-less'),
                        tooltip: l10n.eventDetailCarpoolSeatsLess,
                        onPressed: _seats > minSeats
                            ? () => _setSeats(_seats - 1)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$_seats',
                        key: const ValueKey('carpool-seats'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: t.ink,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      IconButton(
                        key: const ValueKey('carpool-seats-more'),
                        tooltip: l10n.eventDetailCarpoolSeatsMore,
                        onPressed: _seats < maxSeats
                            ? () => _setSeats(_seats + 1)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                )
              : null,
        ),
        const SizedBox(height: 12),
        option(
          value: CarpoolMode.direct,
          title: l10n.eventDetailCarpoolModeDirect,
          extra: Text(
            l10n.eventDetailCarpoolModeDirectHint,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('carpool-submit'),
          label: l10n.eventDetailCarpoolConfirm,
          expand: true,
          onPressed: () => Navigator.of(
            context,
          ).pop<CarpoolChoice>((mode: _mode, seats: _seats)),
        ),
      ],
    );
  }
}
