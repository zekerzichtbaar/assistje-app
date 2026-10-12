import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/lineup_models.dart';
import 'field_painters.dart';
import 'lineup_ui.dart';

/// Breedte van een spelerskaart op het veld.
const double _tokenWidth = 84;

/// Hoogte van een spelerskaart: avatar (48) + naamplaatje.
const double _tokenHeight = 72;

const double _avatarSize = 48;

/// Hoe lang je een kaart vasthoudt voordat hij meekomt (de PWA: 150 ms).
const Duration lineupDragDelay = Duration(milliseconds: 150);

/// Het veld met de posities van de huidige formatie. Elke positie is een
/// [DragTarget]; een speler erop is (voor wie mag bewerken) een
/// [LongPressDraggable].
class LineupField extends StatelessWidget {
  const LineupField({
    super.key,
    required this.painter,
    required this.slots,
    required this.assignments,
    required this.captainId,
    required this.canEdit,
    required this.selectedSlot,
    required this.picking,
    required this.onDrop,
    required this.onTapSlot,
    required this.onSelect,
    required this.onRemove,
    required this.onToggleCaptain,
    required this.onBackgroundTap,
  });

  final FieldPainter painter;
  final List<FormationSlot> slots;
  final Map<String, LineupPlayer?> assignments;
  final int? captainId;
  final bool canEdit;

  /// Aangetikte positie (toont C- en verwijderknop).
  final String? selectedSlot;

  /// Staat er een bankspeler klaar? Dan is elke positie een doel.
  final bool picking;

  final void Function(String slotCode, LineupPlayer player) onDrop;
  final ValueChanged<String> onTapSlot;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;
  final ValueChanged<int> onToggleCaptain;
  final VoidCallback onBackgroundTap;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onBackgroundTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                key: ValueKey('lineup-field-${painter.variant}'),
                painter: painter,
              ),
            ),
            for (final slot in slots)
              Positioned(
                left: (slot.x / 100 * width - _tokenWidth / 2).clamp(
                  0,
                  width - _tokenWidth,
                ),
                top: (slot.y / 100 * height - _tokenHeight / 2).clamp(
                  0,
                  height - _tokenHeight,
                ),
                width: _tokenWidth,
                height: _tokenHeight,
                child: _Slot(
                  slot: slot,
                  player: assignments[slot.code],
                  captain:
                      captainId != null &&
                      assignments[slot.code]?.id == captainId,
                  canEdit: canEdit,
                  selected: selectedSlot == slot.code,
                  picking: picking,
                  onDrop: onDrop,
                  onTap: onTapSlot,
                  onSelect: onSelect,
                  onRemove: onRemove,
                  onToggleCaptain: onToggleCaptain,
                ),
              ),
          ],
        ),
      );
    },
  );
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.slot,
    required this.player,
    required this.captain,
    required this.canEdit,
    required this.selected,
    required this.picking,
    required this.onDrop,
    required this.onTap,
    required this.onSelect,
    required this.onRemove,
    required this.onToggleCaptain,
  });

  final FormationSlot slot;
  final LineupPlayer? player;
  final bool captain;
  final bool canEdit;
  final bool selected;
  final bool picking;
  final void Function(String slotCode, LineupPlayer player) onDrop;
  final ValueChanged<String> onTap;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;
  final ValueChanged<int> onToggleCaptain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = player;
    if (!canEdit) {
      // Kijkstand: een lege plek is gewoon gras.
      return KeyedSubtree(
        key: ValueKey('lineup-slot-${slot.code}'),
        child: current == null
            ? const SizedBox.shrink()
            : _FieldToken(player: current, captain: captain),
      );
    }
    return DragTarget<LineupPlayer>(
      key: ValueKey('lineup-slot-${slot.code}'),
      onWillAcceptWithDetails: (details) => details.data.id != current?.id,
      onAcceptWithDetails: (details) => onDrop(slot.code, details.data),
      builder: (context, candidates, rejected) {
        final over = candidates.isNotEmpty;
        final Widget child;
        if (current == null) {
          child = _EmptySlot(label: slot.label, over: over, picking: picking);
        } else {
          final token = _FieldToken(
            player: current,
            captain: captain,
            selected: selected,
            over: over,
            swappable: picking,
            onToggleCaptain: selected && !picking
                ? () => onToggleCaptain(current.id)
                : null,
            onRemove: selected && !picking ? () => onRemove(slot.code) : null,
          );
          child = LongPressDraggable<LineupPlayer>(
            data: current,
            delay: lineupDragDelay,
            feedback: _DragPreview(player: current),
            childWhenDragging: Opacity(opacity: 0.3, child: token),
            child: token,
          );
        }
        return Semantics(
          label: current == null ? l10n.lineupEmptySlot(slot.label) : null,
          button: true,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (picking) {
                onTap(slot.code);
              } else if (current != null) {
                onSelect(slot.code);
              }
            },
            child: AnimatedScale(
              scale: over ? 1.1 : 1,
              duration: const Duration(milliseconds: 150),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// Een lege plek: stippelrondje met de korte positienaam uit de API.
class _EmptySlot extends StatelessWidget {
  const _EmptySlot({
    required this.label,
    required this.over,
    required this.picking,
  });

  final String label;
  final bool over;
  final bool picking;

  @override
  Widget build(BuildContext context) {
    final Color fill;
    final Color border;
    if (over) {
      fill = const Color(0xB334D399); // emerald-400/70
      border = Colors.white;
    } else if (picking) {
      fill = lineupAmber.withValues(alpha: 0.3);
      border = StatusColors.amber300; // amber-300
    } else {
      fill = const Color(0x66064E3B); // emerald-900/40
      border = Colors.white.withValues(alpha: 0.7);
    }
    return Align(
      alignment: const Alignment(0, -0.75),
      child: Container(
        width: _avatarSize,
        height: _avatarSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fill,
          shape: BoxShape.circle,
          border: Border.all(color: border, width: 2),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}

/// Een speler op het veld: avatar met rugnummer, C en naamplaatje.
class _FieldToken extends StatelessWidget {
  const _FieldToken({
    required this.player,
    required this.captain,
    this.selected = false,
    this.over = false,
    this.swappable = false,
    this.onToggleCaptain,
    this.onRemove,
  });

  final LineupPlayer player;
  final bool captain;
  final bool selected;
  final bool over;

  /// Er staat iemand klaar van de bank: tikken vervangt deze speler.
  final bool swappable;

  /// Gezet = de C is hier te geven/af te nemen (aangetikte kaart).
  final VoidCallback? onToggleCaptain;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final number = player.shirtNumber;
    final toggle = onToggleCaptain;
    final remove = onRemove;
    return Column(
      key: ValueKey('lineup-player-${player.id}'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _avatarSize + 8,
          height: _avatarSize + 4,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AppAvatar(
                name: player.name,
                imageUrl: player.avatarUrl,
                size: _avatarSize,
                ring: selected ? lineupAmber : Colors.white,
                ringWidth: over ? 4 : 2,
              ),
              if (number != null)
                Positioned(left: 0, top: 0, child: ShirtBadge(number: number)),
              if (toggle != null)
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: _CaptainButton(
                    active: captain,
                    label: captain
                        ? l10n.lineupRemoveCaptain
                        : l10n.lineupMakeCaptain,
                    onTap: toggle,
                  ),
                )
              else if (captain)
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Semantics(
                    label: l10n.lineupCaptain,
                    child: const _CaptainBadge(
                      key: ValueKey('lineup-captain-badge'),
                    ),
                  ),
                ),
              if (remove != null)
                Positioned(
                  right: 0,
                  top: 0,
                  child: _RoundButton(
                    key: ValueKey('lineup-remove-${player.id}'),
                    label: l10n.lineupRemoveFromField,
                    color: const Color(0xFFEF4444),
                    onTap: remove,
                    child: const Icon(
                      PhosphorIconsBold.x,
                      size: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (swappable)
                const Positioned(right: 0, bottom: 0, child: _SwapBadge()),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Container(
          constraints: const BoxConstraints(maxWidth: _tokenWidth),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0x73000000),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            player.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _CaptainBadge extends StatelessWidget {
  const _CaptainBadge({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: lineupAmber,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white),
    ),
    child: const Text(
      'C',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF111827),
        height: 1,
      ),
    ),
  );
}

/// De C-knop op een aangetikte kaart: vol = draagt de C, gestippeld = niet.
class _CaptainButton extends StatelessWidget {
  const _CaptainButton({
    required this.active,
    required this.label,
    required this.onTap,
  });

  final bool active;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => _RoundButton(
    key: const ValueKey('lineup-captain-toggle'),
    label: label,
    color: active ? lineupAmber : Colors.white,
    borderColor: active ? Colors.white : lineupAmber,
    onTap: onTap,
    selected: active,
    child: Text(
      'C',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        height: 1,
        color: active ? const Color(0xFF111827) : const Color(0xFF6B7280),
      ),
    ),
  );
}

class _SwapBadge extends StatelessWidget {
  const _SwapBadge();

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: lineupAmber,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white),
    ),
    child: const Icon(
      PhosphorIconsBold.arrowsLeftRight,
      size: 11,
      color: Color(0xFF111827),
    ),
  );
}

/// Klein rond knopje op een kaart, met een ruimer tikvlak.
class _RoundButton extends StatelessWidget {
  const _RoundButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    required this.child,
    this.borderColor,
    this.selected,
  });

  final String label;
  final Color color;
  final Color? borderColor;
  final VoidCallback onTap;
  final Widget child;
  final bool? selected;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: label,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Haptics.light();
        onTap();
      },
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor ?? Colors.white),
        ),
        child: child,
      ),
    ),
  );
}

/// Wat onder de vinger meekomt tijdens het slepen.
class _DragPreview extends StatelessWidget {
  const _DragPreview({required this.player});

  final LineupPlayer player;

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: AppAvatar(
        name: player.name,
        imageUrl: player.avatarUrl,
        size: 56,
        ring: lineupAmber,
      ),
    ),
  );
}

/// De sleep-preview, ook voor de bank.
Widget lineupDragPreview(LineupPlayer player) => _DragPreview(player: player);
