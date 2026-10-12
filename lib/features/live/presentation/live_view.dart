import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/live_controller.dart';
import '../application/live_share.dart';
import '../data/models/live_feed.dart';
import '../data/models/live_models.dart';
import 'widgets/live_add_event_sheet.dart';
import 'widgets/live_clock_controls.dart';
import 'widgets/live_scoreboard.dart';
import 'widgets/live_share_row.dart';
import 'widgets/live_timeline.dart';
import 'widgets/live_ui.dart';

/// De live-wedstrijd [eventId]: scorebord met klok, volgen, meekijkers en de
/// tijdlijn met duimpjes — en voor wie bijhoudt (`can_manage`) de klok-
/// bediening, "Gebeurtenis" toevoegen en verwijderen.
///
/// Pollt elke 12 s zolang de wedstrijd live is en de app op de voorgrond
/// staat (zie [LiveController]). De klok tikt lokaal elke seconde door.
class LiveView extends ConsumerStatefulWidget {
  const LiveView({super.key, required this.eventId});

  final int eventId;

  @override
  ConsumerState<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends ConsumerState<LiveView> {
  late final AppLifecycleListener _lifecycle;

  /// De controller van de huidige stand; bewaard zodat [dispose] de polling
  /// kan stoppen zonder `ref`.
  LiveController? _notifier;

  /// Tikt elke seconde zolang de klok loopt.
  Timer? _ticker;
  DateTime _now = DateTime.now();

  /// Lopende klok- of tijdlijnactie.
  bool _busy = false;

  LiveKey _key(int teamId) => (teamId: teamId, eventId: widget.eventId);

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onStateChange: _onLifecycle);
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _ticker?.cancel();
    _notifier?.setActive(false);
    super.dispose();
  }

  void _onLifecycle(AppLifecycleState state) {
    final active = state == AppLifecycleState.resumed;
    if (state == AppLifecycleState.inactive) return;
    _notifier?.setActive(active);
  }

  void _syncTicker(LiveMatch? match) {
    final running = match != null && match.clock.inPlay && match.clock.running;
    if (running && _ticker == null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _now = DateTime.now());
      });
    } else if (!running && _ticker != null) {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  Future<void> _run(
    Future<Object?> Function() action, {
    required String errorTitle,
  }) async {
    if (_busy) return;
    setState(() => _busy = true);
    final error = await action();
    if (!mounted) return;
    setState(() {
      _busy = false;
      _now = DateTime.now();
    });
    if (error != null) {
      showLiveError(context, errorTitle, error);
    } else {
      unawaited(Haptics.light());
    }
  }

  Future<void> _toggleFollow(LiveController controller) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final error = await controller.toggleFollow();
    if (error != null && mounted) {
      showLiveError(context, l10n.liveFollowError, error);
    }
  }

  Future<void> _toggleReaction(
    LiveController controller,
    String itemKey,
    String emoji,
  ) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final error = await controller.toggleReaction(itemKey, emoji);
    if (error != null && mounted) {
      showLiveError(context, l10n.liveReactError, error);
    }
  }

  Future<void> _openPicker(
    LiveController controller,
    LiveMatch match,
    LiveFeedItem item,
  ) async {
    final l10n = AppLocalizations.of(context);
    String? mine;
    for (final r in match.reactions[item.itemKey] ?? const <LiveReaction>[]) {
      if (r.mine) mine = r.emoji;
    }
    final emoji = await showAppSheet<String>(
      context: context,
      title: l10n.liveReact,
      builder: (_) => LiveEmojiPicker(emoji: match.reactionEmoji, mine: mine),
    );
    if (emoji == null || !mounted) return;
    await _toggleReaction(controller, item.itemKey, emoji);
  }

  Future<void> _delete(LiveController controller, LiveFeedItem item) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmLive(
      context,
      title: l10n.liveDeleteItem,
      message: l10n.liveDeleteConfirm,
      confirmLabel: l10n.liveDeleteConfirmLabel,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _run(
      () => controller.deleteItem(item),
      errorTitle: l10n.liveDeleteError,
    );
  }

  Future<void> _add(
    LiveController controller,
    LiveMatch match,
    TeamMembership membership,
  ) async {
    final now = DateTime.now();
    final clock = match.clock;
    // Tijdens de wedstrijd de klok als voorgevulde minuut, maar in de
    // blessuretijd op de grens (die klemt de server toch).
    final end = clock.periodEnd;
    var minute = clock.inPlay ? clock.minuteAt(now) : 0;
    if (clock.inPlay && end != null && clock.stoppageAt(now) > 0) minute = end;
    final added = await showLiveAddEventSheet(
      context,
      match: match,
      minute: minute,
      controller: controller,
      sportProfile: membership.sport,
    );
    if (added == LiveAdded.goal) unawaited(Haptics.success());
  }

  Future<void> _retry(LiveController controller) async {
    final error = await controller.refresh();
    if (error != null && mounted) {
      showLiveError(context, AppLocalizations.of(context).liveLoadError, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final key = _key(membership.team.id);
    final provider = liveControllerProvider(key);
    final controller = ref.watch(provider.notifier);
    if (!identical(_notifier, controller)) {
      _notifier = controller;
      controller.setActive(true);
    }

    // Een doelpunt van ons erbij (eigen invoer of via de poll): trillen.
    ref.listen(provider, (previous, next) {
      final before = previous?.value;
      final after = next.value;
      if (before != null && after != null) {
        final known = {
          for (final g in before.goals)
            if (g.isOurs) g.id,
        };
        if (after.goals.any((g) => g.isOurs && !known.contains(g.id))) {
          unawaited(Haptics.success());
        }
      }
    });

    final async = ref.watch(provider);
    final match = async.value;
    _syncTicker(match);
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);

    final List<Widget> slivers;
    if (match != null) {
      slivers = _content(membership, controller, match);
    } else if (async.hasError) {
      slivers = [
        _title(),
        SliverToBoxAdapter(child: _errorState(controller, async.error)),
      ];
    } else {
      slivers = [
        _title(),
        const SliverToBoxAdapter(
          child: Column(
            key: ValueKey('live-loading'),
            children: [
              Skeleton(height: 180, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 3),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('live-screen'),
      backgroundColor: t.sunken,
      body: Semantics(
        label: l10n.screenEventLive,
        explicitChildNodes: true,
        child: AppRefresh(
          onRefresh: () => _retry(controller),
          padding: EdgeInsets.fromLTRB(
            12,
            ShellInsets.top(context),
            12,
            ShellInsets.bottom(context),
          ),
          slivers: slivers,
        ),
      ),
    );
  }

  /// Schermtitel; zelfde key als de placeholder (de shell-tests lezen hem).
  Widget _title() {
    final t = AssistjeTokens.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
        child: Semantics(
          header: true,
          child: Text(
            AppLocalizations.of(context).screenEventLive,
            key: const Key('placeholder-title'),
            style: TextStyle(
              fontSize: 26,
              height: 1.15,
              fontWeight: FontWeight.w700,
              color: t.ink,
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorState(LiveController controller, Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('live-forbidden'),
        icon: PhosphorIconsDuotone.lock,
        title: l10n.liveForbiddenTitle,
        description: l10n.liveForbiddenBody,
      ),
      NotFoundException() => EmptyState(
        key: const ValueKey('live-not-found'),
        icon: PhosphorIconsDuotone.broadcast,
        title: l10n.liveNotFoundTitle,
        description: l10n.liveNotFoundBody,
      ),
      _ => EmptyState(
        key: const ValueKey('live-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.liveLoadError,
        description: liveErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('live-retry'),
          label: l10n.retry,
          onPressed: () => _retry(controller),
        ),
      ),
    };
  }

  List<Widget> _content(
    TeamMembership membership,
    LiveController controller,
    LiveMatch match,
  ) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final feed = buildLiveFeed(match);
    final title = match.event.title;
    return [
      _title(),
      if (title.isNotEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: Text(
              title,
              key: const ValueKey('live-event-title'),
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: LiveScoreboard(
          match: match,
          now: _now,
          onToggleFollow: () => _toggleFollow(controller),
          footer: [
            // Delen mag iedereen, niet alleen wie de klok bedient.
            if (canShareLive(match.event))
              LiveShareRow(event: match.event, teamName: membership.team.name),
            if (match.canManage) ...[
              LiveClockControls(
                match: match,
                now: _now,
                controller: controller,
                run: _run,
                busy: _busy,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: AppButtonBase(
                  key: const ValueKey('live-add'),
                  label: l10n.liveAddEvent,
                  icon: const Icon(PhosphorIconsBold.plus, size: 16),
                  background: t.primary.withValues(alpha: 0.12),
                  foreground: t.primary,
                  expand: true,
                  height: 48,
                  onPressed: _busy
                      ? null
                      : () => _add(controller, match, membership),
                ),
              ),
            ],
          ],
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      SliverToBoxAdapter(
        child: LiveTimeline(
          match: match,
          feed: feed,
          onToggleReaction: (itemKey, emoji) =>
              _toggleReaction(controller, itemKey, emoji),
          onOpenPicker: (item) => _openPicker(controller, match, item),
          onDelete: (item) => _delete(controller, item),
        ),
      ),
    ];
  }
}
