import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/application/agenda_controller.dart';
import '../../application/schedule_import_controller.dart';
import '../../data/models/schedule_import_models.dart';
import '../../data/schedule_file_picker.dart';
import 'schedule_fields.dart';

/// Opent "Wedstrijdprogramma" (`ImportEventsSheet.tsx`) voor de trainer van
/// [teamId]. Wat de sheet toont (ophalen, agendalink, aanvragen) leest hij
/// live uit de agenda van dat team. [onPlan] opent het wedstrijdformulier;
/// zonder blijft dat blok weg.
Future<void> showImportEventsSheet(
  BuildContext context, {
  required int teamId,
  FederationImport? federation,
  VoidCallback? onPlan,
}) => showAppSheet<void>(
  context: context,
  title: AppLocalizations.of(context).scheduleImportTitle,
  scrollable: true,
  builder: (_) =>
      ImportEventsSheet(teamId: teamId, federation: federation, onPlan: onPlan),
);

/// Het programma in de agenda krijgen, in de volgorde van de PWA: ophalen
/// (of de agendalink, of de uitleg waarom dat niet lukt), zelf inplannen,
/// het ons laten doen, en pas daarna het bestand.
class ImportEventsSheet extends ConsumerStatefulWidget {
  const ImportEventsSheet({
    super.key,
    required this.teamId,
    this.federation,
    this.onPlan,
  });

  final int teamId;
  final FederationImport? federation;
  final VoidCallback? onPlan;

  @override
  ConsumerState<ImportEventsSheet> createState() => _ImportEventsSheetState();
}

class _ImportEventsSheetState extends ConsumerState<ImportEventsSheet> {
  late final TextEditingController _feedUrl;
  String _initialFeedUrl = '';

  bool _fetching = false;
  bool _requesting = false;
  bool _savingFeed = false;
  bool _importing = false;

  String? _fetchError;
  String? _requestError;
  String? _feedError;
  String? _fileError;

  ScheduleFile? _file;
  bool _dryRun = false;
  String? _dryRunMessage;

  @override
  void initState() {
    super.initState();
    final data = ref.read(agendaControllerProvider(widget.teamId)).value?.data;
    _initialFeedUrl = ScheduleFeedState.fromJson(data?.scheduleFeed)?.url ?? '';
    _feedUrl = TextEditingController(text: _initialFeedUrl)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _feedUrl.dispose();
    super.dispose();
  }

  ScheduleImportController get _controller =>
      ref.read(scheduleImportControllerProvider);

  /// Gelukt: melding als toast, sheet dicht (zoals de flash op de agenda).
  void _done(ScheduleImportDone done) {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.success());
    showAppToast(
      context,
      title: done.message.isEmpty ? l10n.scheduleImportTitle : done.message,
      closeLabel: l10n.close,
    );
    Navigator.of(context).pop();
  }

  String _failText(ScheduleImportFailed failed) =>
      failed.message ??
      scheduleErrorText(AppLocalizations.of(context), failed.error);

  Future<void> _fetch() async {
    setState(() {
      _fetching = true;
      _fetchError = null;
    });
    final outcome = await _controller.fetch(widget.teamId);
    if (!mounted) return;
    setState(() => _fetching = false);
    switch (outcome) {
      case final ScheduleImportDone done:
        _done(done);
      case final ScheduleImportFailed failed:
        unawaited(Haptics.error());
        setState(() => _fetchError = _failText(failed));
    }
  }

  Future<void> _request() async {
    setState(() {
      _requesting = true;
      _requestError = null;
    });
    final outcome = await _controller.request(widget.teamId);
    if (!mounted) return;
    setState(() => _requesting = false);
    switch (outcome) {
      case final ScheduleImportDone done:
        _done(done);
      case final ScheduleImportFailed failed:
        unawaited(Haptics.error());
        setState(() => _requestError = _failText(failed));
    }
  }

  Future<void> _saveFeed() async {
    final url = _feedUrl.text.trim();
    if (url.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _savingFeed = true;
      _feedError = null;
    });
    final outcome = await _controller.setFeed(widget.teamId, url);
    if (!mounted) return;
    setState(() => _savingFeed = false);
    switch (outcome) {
      case final ScheduleImportDone done:
        _done(done);
      case final ScheduleImportFailed failed:
        unawaited(Haptics.error());
        setState(() => _feedError = _failText(failed));
    }
  }

  Future<void> _pickFile() async {
    final file = await ref.read(scheduleFilePickerProvider).pick();
    if (!mounted || file == null) return;
    setState(() {
      _file = file;
      _fileError = null;
      _dryRunMessage = null;
    });
  }

  Future<void> _import() async {
    final file = _file;
    if (file == null) return;
    setState(() {
      _importing = true;
      _fileError = null;
      _dryRunMessage = null;
    });
    final outcome = await _controller.importFile(
      widget.teamId,
      file,
      dryRun: _dryRun,
    );
    if (!mounted) return;
    setState(() => _importing = false);
    switch (outcome) {
      case ScheduleImportDone(dryRun: true, :final message):
        // Proefimport: niets opgeslagen, dus de sheet blijft open met de
        // telling, zodat de trainer het daarna echt kan importeren.
        unawaited(Haptics.light());
        setState(() => _dryRunMessage = message);
      case final ScheduleImportDone done:
        _done(done);
      case final ScheduleImportFailed failed:
        unawaited(Haptics.error());
        setState(() => _fileError = _failText(failed));
    }
  }

  void _plan() {
    final onPlan = widget.onPlan;
    Navigator.of(context).pop();
    onPlan?.call();
  }

  void _sendProgramme() {
    final router = GoRouter.of(context);
    Navigator.of(context).pop();
    unawaited(router.push(AppRoutes.feedback));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final data = ref.watch(agendaControllerProvider(widget.teamId)).value?.data;
    final canFetch = data?.canFetchSchedule ?? false;
    final request = ScheduleRequestState.parse(data?.scheduleRequest);
    final feed = ScheduleFeedState.fromJson(data?.scheduleFeed);
    final source = widget.federation?.name;

    final top = <Widget>[];
    if (canFetch) {
      top.add(
        _Section(
          key: const ValueKey('schedule-import-fetch'),
          title: l10n.scheduleImportFetchTitle,
          body: source == null
              ? l10n.scheduleImportFetchBody
              : l10n.scheduleImportFetchBodySource(source),
          children: [
            PrimaryButton(
              key: const ValueKey('schedule-import-fetch-button'),
              label: _fetching
                  ? l10n.scheduleImportBusy
                  : l10n.scheduleImportFetchButton,
              expand: true,
              onPressed: _fetching ? null : _fetch,
            ),
            ScheduleFieldError(_fetchError),
          ],
        ),
      );
    } else if (feed != null) {
      final hint = widget.federation?.hint;
      final showFailed = feed.failed && _feedUrl.text == (feed.url ?? '');
      top.add(
        _Section(
          key: const ValueKey('schedule-import-feed'),
          title: feed.url != null
              ? l10n.scheduleImportFeedTitleSet
              : l10n.scheduleImportFeedTitleEmpty,
          body: hint == null
              ? l10n.scheduleImportFeedBody
              : '${l10n.scheduleImportFeedBody} $hint',
          children: [
            if (showFailed)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ScheduleFieldError(
                  l10n.scheduleImportFeedFailed,
                  key: const ValueKey('schedule-import-feed-failed'),
                ),
              ),
            TextField(
              key: const ValueKey('schedule-import-feed-url'),
              controller: _feedUrl,
              enabled: !_savingFeed,
              keyboardType: TextInputType.url,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _saveFeed(),
              decoration: InputDecoration(
                hintText:
                    widget.federation?.example ??
                    l10n.scheduleImportFeedPlaceholder,
              ),
            ),
            ScheduleFieldError(_feedError),
            const SizedBox(height: 12),
            PrimaryButton(
              key: const ValueKey('schedule-import-feed-button'),
              label: _savingFeed
                  ? l10n.scheduleImportFeedBusy
                  : l10n.scheduleImportFeedButton,
              expand: true,
              onPressed: _savingFeed || _feedUrl.text.trim().isEmpty
                  ? null
                  : _saveFeed,
            ),
          ],
        ),
      );
    } else {
      top.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            source == null
                ? l10n.scheduleImportLoginNote
                : l10n.scheduleImportLoginNoteSource(source),
            key: const ValueKey('schedule-import-login-note'),
            style: TextStyle(fontSize: 14, height: 1.5, color: t.muted),
          ),
        ),
      );
    }

    return Column(
      key: const ValueKey('schedule-import-sheet'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...top,
        if (widget.onPlan != null)
          _Section(
            key: const ValueKey('schedule-import-plan'),
            title: l10n.scheduleImportPlanTitle,
            body: l10n.scheduleImportPlanBody,
            children: [
              PrimaryButton(
                key: const ValueKey('schedule-import-plan-button'),
                label: l10n.scheduleImportPlanButton,
                expand: true,
                onPressed: _plan,
              ),
            ],
          ),
        if (request != null)
          _Section(
            key: const ValueKey('schedule-import-request'),
            title: l10n.scheduleRequestTitle,
            body: l10n.scheduleRequestBody,
            children: [
              if (request == ScheduleRequestState.pending)
                Text(
                  l10n.scheduleRequestPending,
                  key: const ValueKey('schedule-import-request-pending'),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.inkSoft,
                  ),
                )
              else
                PrimaryButton(
                  key: const ValueKey('schedule-import-request-button'),
                  label: _requesting
                      ? l10n.scheduleImportBusy
                      : l10n.scheduleRequestButton,
                  expand: true,
                  onPressed: _requesting ? null : _request,
                ),
              ScheduleFieldError(_requestError),
            ],
          )
        else
          _Section(
            key: const ValueKey('schedule-import-send'),
            title: l10n.scheduleRequestTitle,
            body: feed != null
                ? l10n.scheduleSendBodyFeed
                : l10n.scheduleSendBody,
            children: [
              Center(
                child: TextButton(
                  key: const ValueKey('schedule-import-send-link'),
                  onPressed: _sendProgramme,
                  style: TextButton.styleFrom(foregroundColor: t.inkSoft),
                  child: Text(
                    l10n.scheduleSendLink,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        _fileSection(l10n, t, source),
      ],
    );
  }

  Widget _fileSection(AppLocalizations l10n, AssistjeTokens t, String? source) {
    final bodyStyle = TextStyle(fontSize: 14, height: 1.5, color: t.muted);
    const bold = TextStyle(fontWeight: FontWeight.w700);
    final file = _file;
    return _Section(
      key: const ValueKey('schedule-import-file'),
      title: l10n.scheduleFileTitle,
      bottomMargin: 0,
      bodyWidget: Text.rich(
        TextSpan(
          style: bodyStyle,
          children: [
            TextSpan(
              text: source == null
                  ? l10n.scheduleFileIntro
                  : l10n.scheduleFileIntroSource(source),
            ),
            const TextSpan(text: '\n• '),
            const TextSpan(text: '.ics', style: bold),
            TextSpan(text: ': ${l10n.scheduleFileIcs}'),
            const TextSpan(text: '\n• '),
            const TextSpan(text: '.xlsx', style: bold),
            TextSpan(text: ': ${l10n.scheduleFileXlsx}'),
            const TextSpan(text: '\n• '),
            const TextSpan(text: '.csv', style: bold),
            TextSpan(text: ': ${l10n.scheduleFileCsv}'),
            TextSpan(text: '\n${l10n.scheduleFileHomeAway}'),
          ],
        ),
      ),
      children: [
        const SizedBox(height: 4),
        ScheduleFieldLabel(l10n.scheduleFileLabel),
        Row(
          children: [
            SecondaryButton(
              key: const ValueKey('schedule-import-pick'),
              label: file == null
                  ? l10n.scheduleFilePick
                  : l10n.scheduleFileChange,
              onPressed: _importing ? null : _pickFile,
            ),
            if (file != null) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  file.name,
                  key: const ValueKey('schedule-import-file-name'),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: t.inkSoft),
                ),
              ),
            ],
          ],
        ),
        ScheduleFieldError(_fileError),
        const SizedBox(height: 12),
        InkWell(
          key: const ValueKey('schedule-import-dry-run'),
          onTap: _importing
              ? null
              : () {
                  Haptics.selection();
                  setState(() => _dryRun = !_dryRun);
                },
          child: Row(
            children: [
              Checkbox(
                value: _dryRun,
                onChanged: _importing
                    ? null
                    : (v) => setState(() => _dryRun = v ?? false),
              ),
              Expanded(
                child: Text(
                  l10n.scheduleFileDryRun,
                  style: TextStyle(fontSize: 14, color: t.inkSoft),
                ),
              ),
            ],
          ),
        ),
        if (_dryRunMessage != null)
          Container(
            key: const ValueKey('schedule-import-dry-run-result'),
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: t.surface,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              border: Border.all(color: t.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.scheduleFileDryRunResult,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _dryRunMessage!,
                  style: TextStyle(fontSize: 14, color: t.inkSoft),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('schedule-import-submit'),
          label: _importing ? l10n.scheduleImportBusy : l10n.scheduleFileSubmit,
          expand: true,
          onPressed: _importing || file == null ? null : _import,
        ),
      ],
    );
  }
}

/// Eén blok van de sheet: `rounded-2xl border border-line bg-raised p-4`.
class _Section extends StatelessWidget {
  const _Section({
    super.key,
    required this.title,
    this.body,
    this.bodyWidget,
    this.children = const [],
    this.bottomMargin = 20,
  });

  final String title;
  final String? body;
  final Widget? bodyWidget;
  final List<Widget> children;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
        border: Border.all(color: t.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: t.ink,
            ),
          ),
          const SizedBox(height: 4),
          bodyWidget ??
              Text(
                body ?? '',
                style: TextStyle(fontSize: 14, height: 1.5, color: t.muted),
              ),
          if (children.isNotEmpty) ...[const SizedBox(height: 12), ...children],
        ],
      ),
    );
  }
}
