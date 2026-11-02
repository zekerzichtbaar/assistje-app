import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/live_models.dart';
import 'live_ui.dart';

/// Eén schot vastleggen: [side] `us`/`opp`, raak of mis, en bij ons
/// eventueel de nemer.
typedef LiveShootoutKickCallback =
    Future<void> Function(String side, bool scored, int? playerId);

/// De strafschoppenserie (`ShootoutBoard.tsx`): per kant een rij bolletjes
/// (thuis boven, uit onder) met het aantal raak, de winnaar zodra die er is,
/// en voor wie bijhoudt per kant Raak/Mis, de laatste terug en wissen.
///
/// Zonder [onKick] is het alleen kijken (meekijkers, spelers zonder
/// `lineup`). Snel tikken gaat voor alles: één tik is één schot; de nemer
/// kiezen mag maar hoeft niet, en is na elk schot van ons weer leeg.
/// Na vijf per kant loopt de rij door (sudden death); de server zegt wanneer
/// het beslist is.
class LiveShootoutBoard extends StatefulWidget {
  const LiveShootoutBoard({
    super.key,
    required this.match,
    this.busy = false,
    this.onKick,
    this.onUndo,
    this.onClear,
  });

  final LiveMatch match;
  final bool busy;
  final LiveShootoutKickCallback? onKick;
  final Future<void> Function()? onUndo;
  final Future<void> Function()? onClear;

  @override
  State<LiveShootoutBoard> createState() => _LiveShootoutBoardState();
}

class _LiveShootoutBoardState extends State<LiveShootoutBoard> {
  /// De gekozen nemer voor het volgende schot van ons.
  int? _shooter;

  LiveShootout get _shootout => widget.match.clock.shootout!;
  bool get _canEdit => widget.onKick != null;

  Future<void> _kick(String side, bool scored) async {
    if (widget.busy || !_canEdit) return;
    unawaited(scored ? Haptics.success() : Haptics.light());
    final shooter = side == 'us' ? _shooter : null;
    if (side == 'us') setState(() => _shooter = null);
    await widget.onKick!(side, scored, shooter);
  }

  Future<void> _clear() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy || widget.onClear == null) return;
    final ok = await confirmLive(
      context,
      title: l10n.liveShootoutClear,
      message: l10n.liveShootoutClearBody,
      confirmLabel: l10n.liveShootoutClearLabel,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await widget.onClear!();
  }

  Future<void> _pickShooter() async {
    final l10n = AppLocalizations.of(context);
    final players = widget.match.pickers?.players ?? const [];
    final picked = await showAppSheet<({int? id})>(
      context: context,
      title: l10n.liveShootoutShooter,
      scrollable: true,
      builder: (sheetContext) {
        final t = AssistjeTokens.of(sheetContext);
        Widget tile(String text, int? id, Key key) => ListTile(
          key: key,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          title: Text(text, style: TextStyle(fontSize: 15, color: t.ink)),
          trailing: id == _shooter
              ? Icon(PhosphorIconsBold.check, size: 16, color: t.primary)
              : null,
          onTap: () => Navigator.of(sheetContext).pop((id: id)),
        );
        return Column(
          key: const ValueKey('live-shooter-list'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            tile(l10n.liveNone, null, const ValueKey('live-shooter-none')),
            for (final p in players)
              tile(_playerLabel(p), p.id, ValueKey('live-shooter-${p.id}')),
            const SizedBox(height: 8),
          ],
        );
      },
    );
    if (picked == null || !mounted) return;
    setState(() => _shooter = picked.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final event = widget.match.event;
    final shootout = _shootout;
    final weAreHome = event.weAreHome;
    final homeName = event.homeTeam ?? l10n.liveHome;
    final awayName = event.awayTeam ?? l10n.liveAway;
    final ourName = weAreHome ? homeName : awayName;
    final theirName = weAreHome ? awayName : homeName;
    final rows = [
      (
        side: weAreHome ? 'us' : 'opp',
        name: homeName,
        kicks: weAreHome ? shootout.us : shootout.opp,
      ),
      (
        side: weAreHome ? 'opp' : 'us',
        name: awayName,
        kicks: weAreHome ? shootout.opp : shootout.us,
      ),
    ];
    final open = shootout.winner == null;
    final busy = widget.busy;
    final players = widget.match.pickers?.players ?? const [];
    final dark = Theme.of(context).brightness == Brightness.dark;

    String? shooterName;
    for (final p in players) {
      if (p.id == _shooter) shooterName = _playerLabel(p);
    }

    Widget kickButtons(String side) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButtonBase(
          key: ValueKey('live-kick-$side-scored'),
          label: l10n.liveShootoutScored,
          icon: const Icon(PhosphorIconsBold.check, size: 14),
          background: StatusColors.emerald700,
          foreground: Colors.white,
          horizontalPadding: 12,
          onPressed: busy ? null : () => _kick(side, true),
        ),
        const SizedBox(width: 8),
        AppButtonBase(
          key: ValueKey('live-kick-$side-missed'),
          label: l10n.liveShootoutMissed,
          icon: const Icon(PhosphorIconsBold.x, size: 14),
          background: StatusColors.red700,
          foreground: Colors.white,
          horizontalPadding: 12,
          onPressed: busy ? null : () => _kick(side, false),
        ),
      ],
    );

    Widget panel(String side, String name, {Widget? extra}) => Container(
      key: ValueKey('live-kick-panel-$side'),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Wrap: bij grote tekst zakken de knoppen onder de naam.
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: t.inkSoft,
                ),
              ),
              kickButtons(side),
            ],
          ),
          if (extra != null) ...[const SizedBox(height: 8), extra],
        ],
      ),
    );

    final linkStyle = TextStyle(
      fontSize: 12,
      color: t.muted,
      decoration: TextDecoration.underline,
    );

    return Padding(
      key: const ValueKey('live-shootout'),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.liveShootout.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: t.muted,
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _KickRow(
                key: ValueKey('live-shootout-row-${row.side}'),
                name: row.name,
                kicks: row.kicks,
                slots: shootout.slots,
              ),
            ),
          if (shootout.winner != null) ...[
            const SizedBox(height: 8),
            Container(
              key: const ValueKey('live-shootout-winner'),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: shootout.winner == 'us'
                    ? (dark
                          ? StatusColors.emerald500.withValues(alpha: 0.15)
                          : StatusColors.emerald50)
                    : t.raised,
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              ),
              child: Text(
                shootout.winner == 'us'
                    ? l10n.liveShootoutWinUs(ourName)
                    : l10n.liveShootoutWinThem(theirName),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: shootout.winner == 'us'
                      ? (dark
                            ? StatusColors.emerald400
                            : StatusColors.emerald700)
                      : t.inkSoft,
                ),
              ),
            ),
          ],
          if (_canEdit && open) ...[
            const SizedBox(height: 12),
            panel(
              'us',
              ourName,
              extra: players.isEmpty
                  ? null
                  : _ShooterButton(
                      key: const ValueKey('live-shooter'),
                      text: shooterName ?? l10n.liveShootoutShooter,
                      empty: shooterName == null,
                      onTap: busy ? null : _pickShooter,
                    ),
            ),
            const SizedBox(height: 8),
            panel('opp', theirName),
          ],
          if (_canEdit) ...[
            const SizedBox(height: 4),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                if (shootout.hasKicks && widget.onUndo != null)
                  TextButton(
                    key: const ValueKey('live-shootout-undo'),
                    onPressed: busy ? null : widget.onUndo,
                    child: Text(l10n.liveShootoutUndo, style: linkStyle),
                  ),
                if (widget.onClear != null)
                  TextButton(
                    key: const ValueKey('live-shootout-clear'),
                    onPressed: busy ? null : _clear,
                    child: Text(l10n.liveShootoutClear, style: linkStyle),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

String _playerLabel(LivePickerPlayer p) =>
    p.shirtNumber == null ? p.name : '${p.shirtNumber} · ${p.name}';

/// Eén kant: naam, de bolletjes (raak, mis, nog te nemen) en het aantal
/// raak. VoiceOver leest het als één regel: "Team: 3 raak".
class _KickRow extends StatelessWidget {
  const _KickRow({
    super.key,
    required this.name,
    required this.kicks,
    required this.slots,
  });

  final String name;
  final List<LiveShootoutKick> kicks;
  final int slots;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final score = kicks.where((k) => k.scored).length;
    final dots = Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (var i = 0; i < slots; i++)
          if (i < kicks.length)
            Container(
              key: ValueKey(
                'live-kick-${i + 1}-${kicks[i].scored ? 'scored' : 'missed'}',
              ),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kicks[i].scored
                    ? StatusColors.emerald600
                    : StatusColors.red600,
              ),
              child: Icon(
                kicks[i].scored ? PhosphorIconsBold.check : PhosphorIconsBold.x,
                size: 12,
                color: Colors.white,
              ),
            )
          else
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: t.line),
              ),
            ),
      ],
    );
    final kickLabels = [
      for (var i = 0; i < kicks.length; i++)
        kicks[i].scored
            ? l10n.liveShootoutKickScored(i + 1)
            : l10n.liveShootoutKickMissed(i + 1),
    ];
    return Semantics(
      label: [l10n.liveShootoutRow(name, score), ...kickLabels].join(', '),
      excludeSemantics: true,
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: dots),
          const SizedBox(width: 8),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: t.ink,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// De optionele nemer: een keuzeknop die een spelerslijst opent.
class _ShooterButton extends StatelessWidget {
  const _ShooterButton({
    super.key,
    required this.text,
    required this.empty,
    required this.onTap,
  });

  final String text;
  final bool empty;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Material(
      color: t.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: t.line),
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: empty ? t.muted : t.ink,
                    ),
                  ),
                ),
                Icon(PhosphorIconsBold.caretDown, size: 14, color: t.muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
