import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../player_management/application/share_service.dart';
import '../../application/calendar_feed.dart';
import '../../data/models/agenda_models.dart';
import 'duty_icons.dart';

/// "Zet in agenda" naast de agendatitel: opent [showCalendarSubscribeSheet].
class AgendaCalendarButton extends StatelessWidget {
  const AgendaCalendarButton({super.key, required this.data});

  final AgendaData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      label: l10n.agendaCalendarButtonLabel,
      child: Material(
        color: t.surface,
        shape: StadiumBorder(side: BorderSide(color: t.line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const ValueKey('agenda-calendar'),
          onTap: () {
            unawaited(Haptics.light());
            unawaited(showCalendarSubscribeSheet(context, data: data));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: ExcludeSemantics(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PhosphorIcon(
                    PhosphorIconsDuotone.calendarPlus,
                    size: 18,
                    color: t.ink,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.agendaCalendarButton,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: t.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// De agenda-feed kiezen en abonneren (`CalendarPicker` in de PWA):
/// wedstrijden, trainingen en je eigen diensten, plus "alleen waar ik bij
/// ben". Abonneren gaat via `webcal:`; de https-link kun je kopiëren.
Future<void> showCalendarSubscribeSheet(
  BuildContext context, {
  required AgendaData data,
}) {
  return showAppSheet<void>(
    context: context,
    title: AppLocalizations.of(context).agendaCalendarTitle,
    scrollable: true,
    builder: (context) => CalendarSubscribeForm(data: data),
  );
}

class CalendarSubscribeForm extends ConsumerStatefulWidget {
  const CalendarSubscribeForm({super.key, required this.data});

  final AgendaData data;

  @override
  ConsumerState<CalendarSubscribeForm> createState() =>
      _CalendarSubscribeFormState();
}

class _CalendarSubscribeFormState extends ConsumerState<CalendarSubscribeForm> {
  // Alles staat standaard aan: wie de sheet opent wil doorgaans z'n hele
  // seizoen in de agenda. Net als de PWA blijven wedstrijden/trainingen ook
  // aan als hun rij verborgen is, zodat een later ingelezen programma vanzelf
  // in de agenda komt.
  bool _matches = true;
  bool _trainings = true;
  late List<String> _duties = [
    for (final type in widget.data.dutyTypes) type.slug,
  ];
  // Standaard uit: een wedstrijd die ineens verdwijnt is verwarrend.
  bool _onlyMine = false;
  bool _copied = false;
  Timer? _copiedTimer;

  @override
  void dispose() {
    _copiedTimer?.cancel();
    super.dispose();
  }

  String? get _feedUrl => buildAgendaFeedUrl(
    widget.data.agendaFeedUrl,
    AgendaFeedSelection(
      matches: _matches,
      trainings: _trainings,
      // Volgorde van de agenda, niet van aanklikken.
      duties: [
        for (final type in widget.data.dutyTypes)
          if (_duties.contains(type.slug)) type.slug,
      ],
      onlyMine: _onlyMine,
    ),
  );

  void _toggleDuty(String slug) {
    unawaited(Haptics.selection());
    setState(() {
      _duties = _duties.contains(slug)
          ? _duties.where((s) => s != slug).toList()
          : [..._duties, slug];
    });
  }

  Future<void> _subscribe(String url) async {
    final navigator = Navigator.of(context);
    final l10n = AppLocalizations.of(context);
    final launcher = ref.read(externalUrlLauncherProvider);
    final share = ref.read(shareServiceProvider);
    var opened = false;
    try {
      opened = await launcher.open(Uri.parse(toWebcalUrl(url)));
    } on Object {
      opened = false;
    }
    if (!opened) {
      // Geen agenda-app die webcal: aanneemt: dan maar de link meegeven.
      await share.copy(url);
      if (!mounted) return;
      showAppToast(
        context,
        title: l10n.agendaCalendarOpenFailed,
        variant: AppToastVariant.info,
        closeLabel: l10n.close,
      );
    }
    if (mounted) navigator.pop();
  }

  Future<void> _copy(String url) async {
    final l10n = AppLocalizations.of(context);
    await ref.read(shareServiceProvider).copy(url);
    if (!mounted) return;
    unawaited(Haptics.light());
    setState(() => _copied = true);
    _copiedTimer?.cancel();
    _copiedTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
    showAppToast(
      context,
      title: l10n.agendaCalendarCopied,
      closeLabel: l10n.close,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final data = widget.data;
    final url = _feedUrl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (data.hasMatches)
          _FeedRow(
            key: const ValueKey('calendar-matches'),
            icon: PhosphorIconsDuotone.trophy,
            label: l10n.agendaCalendarMatches,
            description: l10n.agendaCalendarMatchesHint,
            checked: _matches,
            onToggle: () {
              unawaited(Haptics.selection());
              setState(() => _matches = !_matches);
            },
          ),
        if (data.hasTrainings)
          _FeedRow(
            key: const ValueKey('calendar-trainings'),
            icon: PhosphorIconsDuotone.strategy,
            label: l10n.agendaCalendarTrainings,
            description: l10n.agendaCalendarTrainingsHint,
            checked: _trainings,
            onToggle: () {
              unawaited(Haptics.selection());
              setState(() => _trainings = !_trainings);
            },
          ),
        for (final type in data.dutyTypes)
          _FeedRow(
            key: ValueKey('calendar-duty-${type.slug}'),
            icon: dutyIconFor(type.icon),
            label: type.name,
            description: l10n.agendaCalendarDutyHint(type.name.toLowerCase()),
            checked: _duties.contains(type.slug),
            onToggle: () => _toggleDuty(type.slug),
          ),
        // Een filter, geen bron — vandaar los van de lijst. Bij alleen
        // diensten valt er niets te filteren: die zijn al persoonlijk.
        if (_matches || _trainings) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Divider(height: 1, thickness: 1, color: t.lineSoft),
          ),
          _FeedRow(
            key: const ValueKey('calendar-only-mine'),
            icon: PhosphorIconsDuotone.userCheck,
            label: l10n.agendaCalendarOnlyMine,
            description: l10n.agendaCalendarOnlyMineHint,
            checked: _onlyMine,
            onToggle: () {
              unawaited(Haptics.selection());
              setState(() => _onlyMine = !_onlyMine);
            },
          ),
        ],
        const SizedBox(height: 8),
        _SubscribeButton(
          key: const ValueKey('calendar-subscribe'),
          label: l10n.agendaCalendarSubscribe,
          onPressed: url == null ? null : () => _subscribe(url),
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('calendar-copy'),
          onPressed: url == null ? null : () => _copy(url),
          style: TextButton.styleFrom(
            foregroundColor: t.inkSoft,
            disabledForegroundColor: t.muted,
            minimumSize: const Size.fromHeight(44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: Text(
            _copied ? l10n.agendaCalendarCopied : l10n.agendaCalendarCopy,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            l10n.agendaCalendarFootnote,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
        ),
      ],
    );
  }
}

/// Eén aan/uit-rij (de PWA gebruikt `aria-pressed`-knoppen met een vinkje).
class _FeedRow extends StatelessWidget {
  const _FeedRow({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    required this.checked,
    required this.onToggle,
  });

  final IconData icon;
  final String label;
  final String description;
  final bool checked;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final background = checked
        ? (dark
              ? StatusColors.emerald500.withValues(alpha: 0.15)
              : StatusColors.emerald50)
        : t.raised;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Semantics(
        toggled: checked,
        button: true,
        child: Material(
          color: background,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: t.surface,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: PhosphorIcon(icon, size: 20, color: t.ink),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: t.ink,
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(fontSize: 12, color: t.muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: checked ? StatusColors.emerald600 : t.surface,
                      border: Border.all(
                        width: 2,
                        color: checked ? StatusColors.emerald600 : t.line,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: checked
                        ? const PhosphorIcon(
                            PhosphorIconsBold.check,
                            size: 14,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Groene hoofdknop (`bg-emerald-600`, uit = `bg-line`), zoals de PWA.
class _SubscribeButton extends StatelessWidget {
  const _SubscribeButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final enabled = onPressed != null;
    return Semantics(
      button: true,
      enabled: enabled,
      child: Material(
        color: enabled ? StatusColors.emerald600 : t.line,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: enabled ? Colors.white : t.muted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
