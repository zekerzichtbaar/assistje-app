import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/live_controller.dart';
import '../../data/models/live_models.dart';
import 'live_ui.dart';

/// Hoeveel minuten voorbij het einde van een deel nog als blessuretijd leest;
/// daarboven is de rust vergeten (zelfde grens als de PWA).
const int liveStoppageGrace = 10;

/// Voert een klok- of tijdlijnactie uit (bezig-staat, toast bij een fout).
typedef LiveRun =
    Future<void> Function(
      Future<Object?> Function() action, {
      required String errorTitle,
    });

/// Trainer-bediening van de wedstrijdklok (`MatchClockControls.tsx`):
/// Start → rust/hervat → volgend deel → einde, met heropenen, speelduur
/// rechtzetten en het verslag wissen. Elke knop die de klok verzet vraagt
/// eerst bevestiging. Hoe de delen heten komt uit `rules.periods`.
///
/// Tijdens de wedstrijd kan de klok gelijkgezet worden; na de eindfluit van
/// een gelijke beker volgen verlenging en/of strafschoppen.
class LiveClockControls extends StatefulWidget {
  const LiveClockControls({
    super.key,
    required this.match,
    required this.now,
    required this.controller,
    required this.run,
    required this.busy,
    this.isCup = false,
  });

  final LiveMatch match;
  final DateTime now;
  final LiveController controller;
  final LiveRun run;
  final bool busy;

  /// Is dit een bekerwedstrijd? Alleen dan valt een gelijke stand te
  /// beslissen (komt uit het event-detail; de live-stand kent de competitie
  /// niet).
  final bool isCup;

  @override
  State<LiveClockControls> createState() => _LiveClockControlsState();
}

class _LiveClockControlsState extends State<LiveClockControls> {
  bool _lateStart = false;
  int _startMinute = 0;
  int? _nextMinute;

  LiveMatch get _match => widget.match;
  LiveClock get _clock => _match.clock;
  LiveController get _c => widget.controller;

  /// Waar het volgende deel standaard begint: het einde van dit deel.
  int _defaultNext(LivePeriodNames names) =>
      _clock.periodEnd ?? (names.minutes ?? 0) * _clock.currentPeriod;

  /// Delen van de reguliere speeltijd (van de server, anders de sport).
  int _regular(LivePeriodNames names) =>
      _clock.regularPeriods > 0 ? _clock.regularPeriods : names.count;

  /// Delen van déze wedstrijd: bij een verlenging meer dan de sport kent.
  int _totalParts(LivePeriodNames names) =>
      _clock.periodEnds.isNotEmpty ? _clock.periodEnds.length : names.count;

  /// Volgt er na dit deel een verlengingsdeel (of loopt de verlenging al)?
  bool _inExtraTime(LivePeriodNames names) =>
      _clock.extraTime && _clock.currentPeriod >= _regular(names);

  /// Volle speeltijd: het einde van het laatste deel (ook na verlenging).
  int? _fullTime(LivePeriodNames names) =>
      _clock.periodEnds.isNotEmpty ? _clock.periodEnds.last : names.fullTime;

  Future<void> _run(Future<Object?> Function() action) {
    final l10n = AppLocalizations.of(context);
    return widget.run(action, errorTitle: l10n.liveClockError);
  }

  Future<void> _start() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final minute = _startMinute;
    final ok = await confirmLive(
      context,
      title: l10n.liveConfirmStartTitle,
      message: minute > 0
          ? l10n.liveConfirmStartFrom(minute)
          : l10n.liveConfirmStartBody,
      confirmLabel: l10n.liveConfirmStartLabel,
    );
    if (!ok || !mounted) return;
    await _run(() => _c.start(minute: minute));
  }

  Future<void> _pause(LivePeriodNames names, {required bool overdue}) async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final boundary = _clock.periodEnd;
    if (overdue && boundary != null) {
      await _overrun(names, boundary);
      return;
    }
    final ok = await confirmLive(
      context,
      title: l10n.liveConfirmBreakTitle(names.breakLabel),
      message: l10n.liveConfirmBreakBody(_clock.labelAt(widget.now)),
      confirmLabel: names.breakLabel,
    );
    if (!ok || !mounted) return;
    // Rusten op de grens van het deel, niet op de klokstand: blessuretijd
    // hoort niet in de nummering (anders begint de tweede helft op 48).
    await _run(() => _c.pause(minute: boundary));
  }

  Future<void> _next(LivePeriodNames names) async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final minute = _nextMinute ?? _defaultNext(names);
    final ok = await confirmLive(
      context,
      title: '${_nextLabel(l10n, names)}?',
      message: l10n.liveConfirmNextBody(minute),
      confirmLabel: l10n.liveConfirmStartLabel,
    );
    if (!ok || !mounted) return;
    await _run(() => _c.nextPeriod(minute: minute));
    if (mounted) setState(() => _nextMinute = null);
  }

  Future<void> _stop() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final ok = await confirmLive(
      context,
      title: l10n.liveConfirmStopTitle,
      message: l10n.liveConfirmStopBody,
      confirmLabel: l10n.liveConfirmStopLabel,
    );
    if (!ok || !mounted) return;
    await _run(_c.stop);
  }

  Future<void> _restore() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final ok = await confirmLive(
      context,
      title: l10n.liveRestoreTitle,
      message: l10n.liveRestoreBody,
      confirmLabel: l10n.liveRestoreLabel,
    );
    if (!ok || !mounted) return;
    await _run(_c.reset);
  }

  Future<void> _resetReport() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final ok = await confirmLive(
      context,
      title: l10n.liveResetTitle,
      message: l10n.liveResetBody,
      confirmLabel: l10n.liveResetConfirm,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _run(_c.reset);
  }

  Future<void> _duration(LivePeriodNames names) async {
    final l10n = AppLocalizations.of(context);
    final minutes = await showAppSheet<int>(
      context: context,
      title: l10n.liveDurationTitle,
      builder: (_) => _DurationSheet(
        current: _clock.minuteAt(widget.now),
        suggestion: _fullTime(names),
      ),
    );
    if (minutes == null || !mounted) return;
    await _run(() => _c.setDuration(minutes));
  }

  Future<void> _overrun(LivePeriodNames names, int boundary) async {
    final l10n = AppLocalizations.of(context);
    final trimCount = _match.entryMinutes.where((m) => m > boundary).length;
    final choice = await showAppSheet<_OverrunChoice>(
      context: context,
      title: l10n.liveOverrunTitle,
      scrollable: true,
      builder: (_) => _OverrunSheet(
        clock: _clock.labelAt(widget.now),
        boundary: boundary,
        part: names.part,
        breakLabel: names.breakLabel,
        nextLabel: _nextLabel(l10n, names),
        trimCount: trimCount,
      ),
    );
    if (choice == null || !mounted) return;
    if (choice.nextMinute == null) {
      await _run(() => _c.pause(minute: boundary, trim: choice.trim));
    } else {
      await _run(
        () => _c.nextPeriod(minute: choice.nextMinute, trim: choice.trim),
      );
    }
  }

  /// De klok gelijkzetten (`ClockSheet` in de PWA): minuut en seconde van
  /// de scheidsrechter overnemen.
  Future<void> _setClock() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final picked = await showAppSheet<({int minute, int second})>(
      context: context,
      title: l10n.liveClockSet,
      builder: (_) => _ClockSheet(
        seconds: _clock.secondsAt(widget.now),
        running: _clock.running,
      ),
    );
    if (picked == null || !mounted) return;
    await _run(() => _c.setClock(minute: picked.minute, second: picked.second));
  }

  Future<void> _extraTime(LivePeriodNames names) async {
    final l10n = AppLocalizations.of(context);
    final extra = _match.rules.extraTime;
    if (widget.busy || extra == null) return;
    final ok = await confirmLive(
      context,
      title: l10n.liveConfirmExtraTimeTitle,
      message: l10n.liveConfirmExtraTimeBody(
        extra.count,
        extra.minutes,
        _fullTime(names) ?? 0,
      ),
      confirmLabel: l10n.liveExtraTime,
    );
    if (!ok || !mounted) return;
    await _run(_c.startExtraTime);
  }

  Future<void> _shootout() async {
    final l10n = AppLocalizations.of(context);
    if (widget.busy) return;
    final ok = await confirmLive(
      context,
      title: l10n.liveConfirmShootoutTitle,
      message: l10n.liveConfirmShootoutBody,
      confirmLabel: l10n.liveConfirmShootoutLabel,
    );
    if (!ok || !mounted) return;
    await widget.run(_c.startShootout, errorTitle: l10n.liveShootoutError);
  }

  String _nextLabel(AppLocalizations l10n, LivePeriodNames names) {
    if (names.part.isEmpty) return l10n.liveResume;
    // In de verlenging heet het naar de verlenging (zoals de PWA).
    if (_inExtraTime(names)) {
      return _clock.currentPeriod == _regular(names)
          ? l10n.liveStartExtraTime
          : l10n.liveStartExtraNext(names.part);
    }
    return l10n.liveStartNext(_clock.currentPeriod + 1, names.part);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final names = LivePeriodNames.of(l10n, _match.rules);
    final clock = _clock;
    final now = widget.now;
    final busy = widget.busy;
    final minute = clock.minuteAt(now);
    final stoppage = clock.stoppageAt(now);
    final boundary = clock.periodEnd;
    final hasNextPart = clock.currentPeriod < _totalParts(names);
    final overrun = clock.running && hasNextPart && stoppage > 0;
    final overdue = overrun && stoppage > liveStoppageGrace;
    final fullTime = _fullTime(names);
    final overtime = clock.inPlay && fullTime != null && minute > fullTime + 30;
    final startsAt = _match.event.startsAt;
    final kickoffPassed =
        !clock.hasStarted && startsAt != null && startsAt.isBefore(now);
    final misfire =
        !_match.hasEntries && startsAt != null && startsAt.isAfter(now);

    final sections = <Widget>[];

    if (!clock.hasStarted) {
      sections.addAll([
        if (kickoffPassed)
          LiveNotice(
            key: const ValueKey('live-kickoff-passed'),
            text: l10n.liveKickoffPassed(
              DateFormat('HH:mm', 'nl').format(startsAt.toLocal()),
            ),
          ),
        _MainButton(
          key: const ValueKey('live-start'),
          label: names.part.isEmpty
              ? l10n.liveStartMatch
              : l10n.liveStartFirst(names.part),
          icon: PhosphorIconsFill.play,
          background: StatusColors.emerald700,
          foreground: Colors.white,
          onPressed: busy ? null : _start,
        ),
        if (_lateStart)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.liveFromMinute,
                style: TextStyle(fontSize: 13, color: t.muted),
              ),
              const SizedBox(width: 8),
              LiveMinuteField(
                key: const ValueKey('live-start-minute'),
                value: _startMinute,
                onChanged: (v) => setState(() => _startMinute = v),
              ),
            ],
          )
        else
          Center(
            child: TextButton(
              key: const ValueKey('live-late-start'),
              onPressed: () => setState(() => _lateStart = true),
              child: Text(
                l10n.liveLateStart,
                style: TextStyle(
                  fontSize: 12,
                  color: t.muted,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
      ]);
    } else if (!clock.isEnded) {
      sections.addAll([
        if (overdue && boundary != null)
          LiveNotice(
            key: const ValueKey('live-overdue'),
            text: l10n.liveOverdue(clock.labelAt(now), names.part),
            onTap: () => _overrun(names, boundary),
          ),
        if (clock.running)
          _MainButton(
            key: const ValueKey('live-pause'),
            label: names.breakLabel,
            icon: PhosphorIconsFill.pause,
            background: overdue
                ? StatusColors.amber700
                : overrun
                ? StatusColors.emerald700
                : t.sunken,
            foreground: overdue || overrun ? Colors.white : t.inkSoft,
            onPressed: busy ? null : () => _pause(names, overdue: overdue),
          )
        else
          _MainButton(
            key: const ValueKey('live-resume'),
            label: l10n.liveResume,
            icon: PhosphorIconsFill.play,
            background: t.sunken,
            foreground: t.inkSoft,
            onPressed: busy ? null : () => _run(_c.resume),
          ),
        if (clock.isPaused && hasNextPart)
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            // Wrap: bij grote tekst (of een lange knop als "Start 2e helft
            // verlenging") zakt de knop onder het minuutveld.
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        names.part.isEmpty
                            ? l10n.liveFromMinute
                            : _inExtraTime(names)
                            ? l10n.liveExtraTimeFrom
                            : l10n.liveNextFrom(
                                clock.currentPeriod + 1,
                                names.part,
                              ),
                        style: TextStyle(fontSize: 12, color: t.muted),
                      ),
                    ),
                    const SizedBox(width: 8),
                    LiveMinuteField(
                      key: const ValueKey('live-next-minute'),
                      value: _nextMinute ?? _defaultNext(names),
                      width: 64,
                      onChanged: (v) => setState(() => _nextMinute = v),
                    ),
                  ],
                ),
                AppButtonBase(
                  key: const ValueKey('live-next'),
                  label: _nextLabel(l10n, names),
                  icon: const Icon(PhosphorIconsFill.play, size: 16),
                  background: StatusColors.emerald700,
                  foreground: Colors.white,
                  horizontalPadding: 12,
                  onPressed: busy ? null : () => _next(names),
                ),
              ],
            ),
          ),
        if (overtime)
          LiveNotice(
            key: const ValueKey('live-overtime'),
            text: l10n.liveOvertime(minute),
          ),
        _MainButton(
          key: const ValueKey('live-stop'),
          label: l10n.liveStop,
          icon: PhosphorIconsFill.stop,
          background: overtime ? StatusColors.red600 : StatusColors.red50,
          foreground: overtime ? Colors.white : StatusColors.red700,
          onPressed: busy ? null : _stop,
        ),
        // Een correctie, geen handeling die bij elke wedstrijd hoort: een
        // tekstknop, geen volle knop.
        Center(
          child: TextButton(
            key: const ValueKey('live-clock-set'),
            onPressed: busy ? null : _setClock,
            child: Text(
              l10n.liveClockSet,
              style: TextStyle(
                fontSize: 12,
                color: t.muted,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        if (misfire)
          Center(
            child: TextButton(
              key: const ValueKey('live-misfire'),
              onPressed: busy ? null : _restore,
              child: Text(
                l10n.liveMisfire,
                style: TextStyle(
                  fontSize: 12,
                  color: t.muted,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
      ]);
    } else {
      sections.add(
        // Wrap: bij grote tekst zakken de knoppen onder de speelduur in
        // plaats van die tot "A…" in te drukken.
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              key: const ValueKey('live-duration'),
              onPressed: busy ? null : () => _duration(names),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: t.line),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
                ),
              ),
              child: Text(
                l10n.liveEndedDuration(clock.mmssAt(now)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: t.inkSoft,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Niet tijdens de strafschoppen: die horen bij een
                // afgefloten wedstrijd (de server heropent dan ook niet).
                // Eerst de serie wissen.
                if (clock.shootout == null) ...[
                  AppButtonBase(
                    key: const ValueKey('live-reopen'),
                    label: l10n.liveReopen,
                    icon: const Icon(
                      PhosphorIconsBold.arrowCounterClockwise,
                      size: 16,
                    ),
                    background: t.sunken,
                    foreground: t.inkSoft,
                    horizontalPadding: 12,
                    onPressed: busy ? null : () => _run(_c.reopen),
                  ),
                  const SizedBox(width: 8),
                ],
                if (_match.hasEntries)
                  // Eén knop voor VoiceOver: het label hoort bij de tikbare
                  // knop zelf (die heeft alleen een icoon).
                  MergeSemantics(
                    child: Semantics(
                      label: l10n.liveResetLabel,
                      button: true,
                      child: AppButtonBase(
                        key: const ValueKey('live-reset'),
                        label: '',
                        icon: const Icon(PhosphorIconsBold.trash, size: 16),
                        background: StatusColors.red50,
                        foreground: StatusColors.red700,
                        horizontalPadding: 12,
                        onPressed: busy ? null : _resetReport,
                      ),
                    ),
                  )
                else
                  AppButtonBase(
                    key: const ValueKey('live-restore'),
                    label: l10n.liveRestoreLabel,
                    icon: const Icon(
                      PhosphorIconsBold.arrowsClockwise,
                      size: 16,
                    ),
                    background: t.sunken,
                    foreground: t.inkSoft,
                    horizontalPadding: 12,
                    onPressed: busy ? null : _restore,
                  ),
              ],
            ),
          ],
        ),
      );
      if (_match.canDecide(isCup: widget.isCup)) {
        sections.add(
          Column(
            key: const ValueKey('live-decide'),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.liveDecidePrompt,
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
              const SizedBox(height: 8),
              // Wrap: bij grote tekst onder elkaar in plaats van afgekapt.
              LayoutBuilder(
                builder: (context, constraints) {
                  final buttons = [
                    if (_match.canStartExtraTime(isCup: widget.isCup))
                      AppButtonBase(
                        key: const ValueKey('live-extra-time'),
                        label: l10n.liveExtraTime,
                        icon: const Icon(PhosphorIconsDuotone.timer, size: 16),
                        background: t.sunken,
                        foreground: t.inkSoft,
                        expand: true,
                        onPressed: busy ? null : () => _extraTime(names),
                      ),
                    AppButtonBase(
                      key: const ValueKey('live-shootout-start'),
                      label: l10n.liveShootout,
                      icon: const Icon(
                        PhosphorIconsDuotone.soccerBall,
                        size: 16,
                      ),
                      background: StatusColors.emerald700,
                      foreground: Colors.white,
                      expand: true,
                      onPressed: busy ? null : _shootout,
                    ),
                  ];
                  final stacked =
                      MediaQuery.textScalerOf(context).scale(14) > 20 ||
                      constraints.maxWidth < 280;
                  if (stacked) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var i = 0; i < buttons.length; i++) ...[
                          if (i > 0) const SizedBox(height: 8),
                          buttons[i],
                        ],
                      ],
                    );
                  }
                  return Row(
                    children: [
                      for (var i = 0; i < buttons.length; i++) ...[
                        if (i > 0) const SizedBox(width: 8),
                        Expanded(child: buttons[i]),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }
    }

    return Padding(
      key: const ValueKey('live-controls'),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < sections.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            sections[i],
          ],
        ],
      ),
    );
  }
}

/// Volle-breedte knop voor starten, rusten en affluiten (allemaal even hoog).
class _MainButton extends StatelessWidget {
  const _MainButton({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => AppButtonBase(
    label: label,
    icon: Icon(icon, size: 16),
    background: background,
    foreground: foreground,
    expand: true,
    height: 48,
    onPressed: onPressed,
  );
}

/// Uitkomst van de correctie-sheet: rust op de grens ([nextMinute] `null`)
/// of het volgende deel vanaf [nextMinute].
class _OverrunChoice {
  const _OverrunChoice({required this.trim, this.nextMinute});

  final bool trim;
  final int? nextMinute;
}

/// De klok is door de rust heen gelopen: begint de rust nu, of is die al
/// geweest? De app raadt dat niet (zie `OverrunSheet` in de PWA).
class _OverrunSheet extends StatefulWidget {
  const _OverrunSheet({
    required this.clock,
    required this.boundary,
    required this.part,
    required this.breakLabel,
    required this.nextLabel,
    required this.trimCount,
  });

  final String clock;
  final int boundary;
  final String part;
  final String breakLabel;
  final String nextLabel;
  final int trimCount;

  @override
  State<_OverrunSheet> createState() => _OverrunSheetState();
}

class _OverrunSheetState extends State<_OverrunSheet> {
  bool _trim = true;
  late int _resumeAt = widget.boundary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    Widget block(List<Widget> children) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            children[i],
          ],
        ],
      ),
    );
    final title = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.ink,
    );
    final body = TextStyle(fontSize: 12, height: 1.35, color: t.muted);

    return Column(
      key: const ValueKey('live-overrun-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.liveOverrunBody(widget.clock, widget.part, widget.boundary),
          style: TextStyle(fontSize: 14, color: t.inkSoft),
        ),
        const SizedBox(height: 16),
        block([
          Text(l10n.liveOverrunBreakTitle, style: title),
          Text(
            l10n.liveOverrunBreakBody(widget.boundary, widget.part),
            style: body,
          ),
          PrimaryButton(
            key: const ValueKey('live-overrun-break'),
            label: l10n.liveOverrunBreakButton(
              widget.breakLabel,
              widget.boundary,
            ),
            expand: true,
            onPressed: () =>
                Navigator.of(context).pop(_OverrunChoice(trim: _trim)),
          ),
        ]),
        const SizedBox(height: 12),
        block([
          Text(l10n.liveOverrunNextTitle, style: title),
          Text(l10n.liveOverrunNextBody, style: body),
          Row(
            children: [
              Text(l10n.liveFromMinute, style: body),
              const SizedBox(width: 8),
              LiveMinuteField(
                key: const ValueKey('live-overrun-minute'),
                value: _resumeAt,
                width: 72,
                onChanged: (v) => setState(() => _resumeAt = v),
              ),
            ],
          ),
          AppButtonBase(
            key: const ValueKey('live-overrun-next'),
            label: widget.nextLabel,
            background: StatusColors.emerald700,
            foreground: Colors.white,
            expand: true,
            onPressed: () => Navigator.of(
              context,
            ).pop(_OverrunChoice(trim: _trim, nextMinute: _resumeAt)),
          ),
        ]),
        if (widget.trimCount > 0) ...[
          const SizedBox(height: 12),
          CheckboxListTile.adaptive(
            key: const ValueKey('live-overrun-trim'),
            value: _trim,
            onChanged: (v) => setState(() => _trim = v ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.liveOverrunTrim(widget.trimCount, widget.boundary),
              style: TextStyle(fontSize: 12, color: t.inkSoft),
            ),
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}

/// De gelopen speeltijd rechtzetten na de eindfluit.
class _DurationSheet extends StatefulWidget {
  const _DurationSheet({required this.current, required this.suggestion});

  final int current;
  final int? suggestion;

  @override
  State<_DurationSheet> createState() => _DurationSheetState();
}

class _DurationSheetState extends State<_DurationSheet> {
  late int _minutes = widget.current.clamp(1, 300);
  int _version = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final suggestion = widget.suggestion;
    return Column(
      key: const ValueKey('live-duration-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.liveDurationBody,
          style: TextStyle(fontSize: 14, color: t.inkSoft),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: LiveMinuteField(
            key: ValueKey('live-duration-minutes-$_version'),
            value: _minutes,
            min: 1,
            max: 300,
            width: 112,
            label: l10n.liveDurationMinutes,
            onChanged: (v) => setState(() => _minutes = v),
          ),
        ),
        if (suggestion != null && suggestion != _minutes) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: SecondaryButton(
              key: const ValueKey('live-duration-suggest'),
              label: l10n.liveDurationSuggest(suggestion),
              onPressed: () => setState(() {
                _minutes = suggestion;
                _version++;
              }),
            ),
          ),
        ],
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('live-duration-save'),
          label: l10n.liveSave,
          expand: true,
          onPressed: () => Navigator.of(context).pop(_minutes),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// De klok gelijkzetten tijdens de wedstrijd, op minuut én seconde
/// (`ClockSheet` in de PWA). Voorgevuld met waar de klok nu staat, zodat
/// een kleine correctie één getal is; daarna tikt het veld niet mee.
class _ClockSheet extends StatefulWidget {
  const _ClockSheet({required this.seconds, required this.running});

  /// Waar de klok nu staat, in seconden.
  final int seconds;
  final bool running;

  @override
  State<_ClockSheet> createState() => _ClockSheetState();
}

class _ClockSheetState extends State<_ClockSheet> {
  late int _minute = (widget.seconds ~/ 60).clamp(0, 120);
  late int _second = widget.seconds % 60;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final time = '$_minute:${_second.toString().padLeft(2, '0')}';
    return Column(
      key: const ValueKey('live-clock-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.running
              ? l10n.liveClockSetBodyRunning
              : l10n.liveClockSetBodyPaused,
          style: TextStyle(fontSize: 14, color: t.inkSoft),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            LiveMinuteField(
              key: const ValueKey('live-clock-minute'),
              value: _minute,
              width: 96,
              label: l10n.liveClockMinutes,
              onChanged: (v) => setState(() => _minute = v),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ':',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: t.muted,
                ),
              ),
            ),
            LiveMinuteField(
              key: const ValueKey('live-clock-second'),
              value: _second,
              max: 59,
              width: 96,
              label: l10n.liveClockSeconds,
              onChanged: (v) => setState(() => _second = v),
            ),
          ],
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('live-clock-save'),
          label: l10n.liveClockSetTo(time),
          expand: true,
          onPressed: () =>
              Navigator.of(context).pop((minute: _minute, second: _second)),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
