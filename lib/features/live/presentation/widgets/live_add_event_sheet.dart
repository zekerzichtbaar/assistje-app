import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/live_controller.dart';
import '../../data/models/live_models.dart';
import 'live_ui.dart';

/// Tabblad in de toevoeg-sheet.
enum LiveAddType { goal, opponent, sub, other }

/// Wat er is toegevoegd (voor de trilling bij een doelpunt).
enum LiveAdded { goal, other }

/// Opent de sheet "Gebeurtenis toevoegen" (`AddLiveEventSheet.tsx`); geeft
/// terug wat er is vastgelegd, of `null` als de sheet zonder toevoegen sloot.
Future<LiveAdded?> showLiveAddEventSheet(
  BuildContext context, {
  required LiveMatch match,
  required int minute,
  required LiveController controller,
  required Map<String, dynamic> sportProfile,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<LiveAdded>(
    context: context,
    title: l10n.liveAddTitle,
    scrollable: true,
    builder: (_) => LiveAddEventForm(
      match: match,
      minute: minute,
      controller: controller,
      sportProfile: sportProfile,
    ),
  );
}

/// Het formulier in de sheet: tabbladen uit `rules` (geen doelpunten bij
/// een sport zonder doelpuntenmakers, "Overige" alleen met kaarten of
/// momenten), minuut, en de spelerskeuze uit `pickers` (veld en bank apart
/// zodra er een opstelling is).
class LiveAddEventForm extends StatefulWidget {
  const LiveAddEventForm({
    super.key,
    required this.match,
    required this.minute,
    required this.controller,
    required this.sportProfile,
  });

  final LiveMatch match;
  final int minute;
  final LiveController controller;

  /// Het sportprofiel van het team (`/me`): de term voor een doelpunt en of
  /// de sport strafschoppen bijhoudt.
  final Map<String, dynamic> sportProfile;

  @override
  State<LiveAddEventForm> createState() => _LiveAddEventFormState();
}

class _LiveAddEventFormState extends State<LiveAddEventForm> {
  late final List<LiveAddType> _types = [
    if (_rules.tracksScorers) ...[LiveAddType.goal, LiveAddType.opponent],
    LiveAddType.sub,
    if (_rules.cardTypes.isNotEmpty || _rules.momentTypes.isNotEmpty)
      LiveAddType.other,
  ];
  late LiveAddType _type = _types.first;
  late int _minute = widget.minute.clamp(0, 120);
  int? _player;
  int? _assist;
  int? _off;
  int? _on;
  late String _cardType = _rules.cardTypes.isEmpty
      ? ''
      : _rules.cardTypes.first.type;

  /// `card` of het type van een moment.
  late String _otherKind = _rules.cardTypes.isNotEmpty
      ? _cardKind
      : (_rules.momentTypes.isEmpty
            ? _cardKind
            : _rules.momentTypes.first.type);
  bool _penalty = false;
  bool _busy = false;

  static const String _cardKind = 'card';

  LiveRules get _rules => widget.match.rules;
  LivePickers get _pickers => widget.match.pickers ?? const LivePickers();

  bool get _ownGoal => _type == LiveAddType.opponent && _player != null;

  bool get _tracksPenalties => widget.sportProfile['tracks_penalties'] == true;

  String _goalTerm(AppLocalizations l10n) {
    final terms = widget.sportProfile['terms'];
    if (terms is Map) {
      final goal = terms['goal'];
      if (goal is String && goal.trim().isNotEmpty) return goal;
    }
    return l10n.liveTabGoal;
  }

  void _choose(LiveAddType type) {
    setState(() {
      _type = type;
      _player = null;
      _assist = null;
      _off = null;
      _on = null;
      _penalty = false;
    });
  }

  bool get _canSubmit => switch (_type) {
    LiveAddType.opponent => true,
    LiveAddType.goal => _player != null,
    LiveAddType.other => _otherKind != _cardKind || _player != null,
    LiveAddType.sub => _off != null && _on != null && _off != _on,
  };

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final c = widget.controller;
    setState(() => _busy = true);
    final minute = _minute;
    final player = _player;
    final Object? error;
    final LiveAdded added;
    switch (_type) {
      case LiveAddType.goal:
        added = LiveAdded.goal;
        error = await c.addGoal(
          minute: minute,
          playerId: player!,
          assistPlayerId: _assist,
          penalty: _penalty,
        );
      case LiveAddType.opponent:
        added = LiveAdded.other;
        error = player != null
            ? await c.addGoal(minute: minute, playerId: player, ownGoal: true)
            : await c.addOpponentGoal(minute: minute);
      case LiveAddType.sub:
        added = LiveAdded.other;
        error = await c.addSub(
          minute: minute,
          offPlayerId: _off!,
          onPlayerId: _on!,
        );
      case LiveAddType.other:
        added = LiveAdded.other;
        error = _otherKind == _cardKind
            ? await c.addCard(
                minute: minute,
                type: _cardType,
                playerId: player!,
              )
            : await c.addMoment(
                minute: minute,
                type: _otherKind,
                playerId: player,
              );
    }
    if (!mounted) return;
    setState(() => _busy = false);
    if (error != null) {
      showLiveError(context, l10n.liveAddError, error);
      return;
    }
    Navigator.of(context).pop(added);
  }

  Future<void> _pick({
    required String key,
    required int? current,
    required void Function(int?) onPicked,
    required bool benchFirst,
    int? exclude,
    String? noneLabel,
  }) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showAppSheet<_Picked>(
      context: context,
      scrollable: true,
      builder: (_) => _PlayerList(
        pickers: _pickers,
        current: current,
        exclude: exclude,
        benchFirst: benchFirst,
        noneLabel: noneLabel,
        l10n: l10n,
      ),
    );
    if (picked == null || !mounted) return;
    setState(() => onPicked(picked.id));
  }

  String _nameOf(int? id) {
    if (id == null) return '';
    for (final p in [..._pickers.present, ..._pickers.allPlayers]) {
      if (p.id == id) return _label(p);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final muted = TextStyle(fontSize: 14, color: t.muted);

    Widget field(
      String label,
      String fieldKey, {
      required int? value,
      required void Function(int?) onPicked,
      String? placeholder,
      int? exclude,
      bool benchFirst = false,
      String? noneLabel,
    }) => _Field(
      label: label,
      child: _PickerButton(
        key: ValueKey('live-pick-$fieldKey'),
        text: value == null
            ? (placeholder ?? l10n.liveChoosePlayer)
            : _nameOf(value),
        empty: value == null,
        onTap: () => _pick(
          key: fieldKey,
          current: value,
          onPicked: onPicked,
          benchFirst: benchFirst,
          exclude: exclude,
          noneLabel: noneLabel,
        ),
      ),
    );

    final body = <Widget>[];
    switch (_type) {
      case LiveAddType.goal:
        body.addAll([
          field(
            l10n.liveScorer,
            'scorer',
            value: _player,
            exclude: _assist,
            onPicked: (id) {
              _player = id;
              if (id != null && id == _assist) _assist = null;
            },
          ),
          field(
            l10n.liveAssistLabel,
            'assist',
            value: _assist,
            exclude: _player,
            placeholder: l10n.liveNone,
            noneLabel: l10n.liveNone,
            onPicked: (id) => _assist = id,
          ),
          if (_tracksPenalties)
            CheckboxListTile(
              key: const ValueKey('live-penalty'),
              value: _penalty,
              onChanged: (v) => setState(() => _penalty = v ?? false),
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.livePenaltyToggle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: t.ink,
                ),
              ),
            ),
          GestureDetector(
            key: const ValueKey('live-own-goal-hint'),
            onTap: () => _choose(LiveAddType.opponent),
            child: Text(l10n.liveOwnGoalHint, style: muted),
          ),
        ]);
      case LiveAddType.opponent:
        body.addAll([
          field(
            l10n.liveOwnGoalOf,
            'own-goal',
            value: _player,
            placeholder: l10n.liveOwnGoalNone,
            noneLabel: l10n.liveOwnGoalNone,
            onPicked: (id) => _player = id,
          ),
          Text(
            _ownGoal ? l10n.liveOwnGoalExplain : l10n.liveOpponentExplain,
            style: muted,
          ),
        ]);
      case LiveAddType.sub:
        body.addAll([
          field(
            l10n.liveSubOff,
            'off',
            value: _off,
            exclude: _on,
            onPicked: (id) => _off = id,
          ),
          field(
            l10n.liveSubOn,
            'on',
            value: _on,
            exclude: _off,
            benchFirst: true,
            onPicked: (id) => _on = id,
          ),
        ]);
      case LiveAddType.other:
        final kinds = [
          if (_rules.cardTypes.isNotEmpty)
            LiveTypeOption(type: _cardKind, label: l10n.liveCard),
          ..._rules.momentTypes,
        ];
        body.addAll([
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final kind in kinds)
                AppPill(
                  key: ValueKey('live-kind-${kind.type}'),
                  label: kind.label.isEmpty ? kind.type : kind.label,
                  selected: _otherKind == kind.type,
                  onTap: () => setState(() {
                    _otherKind = kind.type;
                    _player = null;
                  }),
                ),
            ],
          ),
          if (_otherKind == _cardKind)
            _Field(
              label: l10n.liveCardColor,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final card in _rules.cardTypes)
                    AppPill(
                      key: ValueKey('live-card-type-${card.type}'),
                      label: card.label.isEmpty ? card.type : card.label,
                      selected: _cardType == card.type,
                      onTap: () => setState(() => _cardType = card.type),
                    ),
                ],
              ),
            ),
          field(
            _otherKind == _cardKind ? l10n.livePlayer : l10n.livePlayerOptional,
            'player',
            value: _player,
            noneLabel: _otherKind == _cardKind ? null : l10n.liveNoName,
            placeholder: _otherKind == _cardKind ? null : l10n.liveNoName,
            onPicked: (id) => _player = id,
          ),
          if (_otherKind != _cardKind)
            Text(l10n.liveMomentExplain, style: muted),
        ]);
    }

    return Column(
      key: const ValueKey('live-add-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_types.length > 1)
          AppTabPills<LiveAddType>(
            tabs: [
              for (final type in _types)
                AppTabPill(
                  value: type,
                  label: switch (type) {
                    LiveAddType.goal => _goalTerm(l10n),
                    LiveAddType.opponent => l10n.liveTabOpponent,
                    LiveAddType.sub => l10n.liveTabSub,
                    LiveAddType.other => l10n.liveTabOther,
                  },
                ),
            ],
            selected: _type,
            onChanged: _choose,
          ),
        const SizedBox(height: 16),
        _Field(
          label: l10n.liveMinute,
          child: Align(
            alignment: Alignment.centerLeft,
            child: LiveMinuteField(
              key: const ValueKey('live-add-minute'),
              value: _minute,
              onChanged: (v) => _minute = v,
            ),
          ),
        ),
        for (final w in body) ...[const SizedBox(height: 12), w],
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('live-add-submit'),
          label: l10n.liveAddSubmit,
          expand: true,
          loading: _busy,
          onPressed: _busy || !_canSubmit ? null : () => unawaited(_submit()),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

String _label(LivePickerPlayer p) =>
    p.shirtNumber == null ? p.name : '${p.shirtNumber} · ${p.name}';

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _PickerButton extends StatelessWidget {
  const _PickerButton({
    super.key,
    required this.text,
    required this.empty,
    required this.onTap,
  });

  final String text;
  final bool empty;
  final VoidCallback onTap;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: empty ? t.muted : t.ink,
                  ),
                ),
              ),
              Icon(PhosphorIconsBold.caretDown, size: 14, color: t.muted),
            ],
          ),
        ),
      ),
    );
  }
}

/// Keuze uit de spelerslijst; [id] `null` = "niemand".
class _Picked {
  const _Picked(this.id);

  final int? id;
}

/// De spelerslijst in een sheet: met een opstelling veld en bank apart
/// (de relevante groep bovenaan), anders alle aanwezigen.
class _PlayerList extends StatelessWidget {
  const _PlayerList({
    required this.pickers,
    required this.current,
    required this.exclude,
    required this.benchFirst,
    required this.noneLabel,
    required this.l10n,
  });

  final LivePickers pickers;
  final int? current;
  final int? exclude;
  final bool benchFirst;
  final String? noneLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    List<LivePickerPlayer> without(List<LivePickerPlayer> list) => [
      for (final p in list)
        if (p.id != exclude) p,
    ];
    final groups = <(String, List<LivePickerPlayer>)>[
      if (pickers.hasLineup) ...[
        if (benchFirst) (l10n.liveBench, without(pickers.bench)),
        (l10n.liveOnField, without(pickers.onField)),
        if (!benchFirst) (l10n.liveBench, without(pickers.bench)),
      ] else
        (l10n.livePlayers, without(pickers.players)),
    ];

    Widget tile(String text, int? id, {Key? key}) => ListTile(
      key: key,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(text, style: TextStyle(fontSize: 15, color: t.ink)),
      trailing: id == current
          ? Icon(PhosphorIconsBold.check, size: 16, color: t.primary)
          : null,
      onTap: () => Navigator.of(context).pop(_Picked(id)),
    );

    return Column(
      key: const ValueKey('live-player-list'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (noneLabel != null)
          tile(noneLabel!, null, key: const ValueKey('live-player-none')),
        for (final (label, players) in groups)
          if (players.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: t.muted,
                ),
              ),
            ),
            for (final p in players)
              tile(_label(p), p.id, key: ValueKey('live-player-${p.id}')),
          ],
        const SizedBox(height: 8),
      ],
    );
  }
}
