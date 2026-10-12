import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/schedule_controller.dart';
import '../../application/schedule_form_values.dart';
import '../../data/models/schedule_models.dart';
import 'schedule_fields.dart';

/// Max. lengtes zoals de API (`StoreEventRequest`).
const int scheduleTitleMax = 120;
const int scheduleVenueMax = 160;
const int scheduleNotesMax = 1000;
const int scheduleTeamMax = 120;

/// Het icoon bij een soort event (zoals de PWA).
IconData scheduleTypeIcon(ScheduleType type) => switch (type) {
  ScheduleType.training => PhosphorIconsDuotone.strategy,
  ScheduleType.match => PhosphorIconsDuotone.trophy,
  ScheduleType.activity => PhosphorIconsDuotone.confetti,
};

/// Het event-formulier (`EventFormSheet.tsx`): type, datum en tijden,
/// locatie, wedstrijdgegevens of titel, opmerking, wekelijks herhalen
/// (nieuwe training), toeschouwers (activiteit) en "alle volgende"
/// (training bewerken).
///
/// [onSubmit] verstuurt; bij succes roept het formulier [onSaved] aan.
/// Veldfouten (422) komen bij het veld, andere fouten als toast.
class ScheduleEventForm extends StatefulWidget {
  const ScheduleEventForm({
    super.key,
    required this.data,
    required this.onSubmit,
    required this.onSaved,
  });

  final ScheduleFormData data;
  final Future<ScheduleOutcome> Function(ScheduleDraft draft) onSubmit;
  final void Function(ScheduleWriteResult result) onSaved;

  @override
  State<ScheduleEventForm> createState() => _ScheduleEventFormState();
}

class _ScheduleEventFormState extends State<ScheduleEventForm> {
  late final ScheduleFormValues _values;
  late final TextEditingController _title;
  late final TextEditingController _venue;
  late final TextEditingController _notes;
  late final TextEditingController _opponent;

  bool _busy = false;
  String? _localError;
  ValidationException? _validation;

  ScheduleEvent? get _event => widget.data.event;
  bool get _isEdit => widget.data.isEdit;
  ScheduleOptions get _options => widget.data.options;

  @override
  void initState() {
    super.initState();
    _values = ScheduleFormValues.initial(_options, event: _event);
    _title = TextEditingController(text: _values.title);
    _venue = TextEditingController(text: _values.venue);
    _notes = TextEditingController(text: _values.notes);
    _opponent = TextEditingController(text: _values.opponent);
  }

  @override
  void dispose() {
    _title.dispose();
    _venue.dispose();
    _notes.dispose();
    _opponent.dispose();
    super.dispose();
  }

  String? _fieldError(String field) => _validation?.fieldError(field);

  void _update(VoidCallback change) => setState(() {
    change();
    _localError = null;
  });

  // --- Kiezers -------------------------------------------------------------

  Future<DateTime?> _pickDate(DateTime? current, {DateTime? first}) {
    unawaited(Haptics.selection());
    final now = DateTime.now();
    final firstDate = first ?? DateTime(now.year - 2);
    var initial = current ?? first ?? now;
    if (initial.isBefore(firstDate)) initial = firstDate;
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: DateTime(now.year + 3, 12, 31),
      locale: const Locale('nl'),
    );
  }

  Future<ClockTime?> _pickTime(
    ClockTime? current, {
    ClockTime? fallback,
  }) async {
    unawaited(Haptics.selection());
    final base = current ?? fallback ?? (hour: 19, minute: 0);
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: base.hour, minute: base.minute),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    return picked == null ? null : (hour: picked.hour, minute: picked.minute);
  }

  Future<void> _chooseDate() async {
    final picked = await _pickDate(_values.date);
    if (picked == null || !mounted) return;
    _update(() {
      _values.date = picked;
      final until = _values.recurUntil;
      if (until != null && until.isBefore(picked)) _values.recurUntil = picked;
    });
  }

  Future<void> _chooseRecurUntil() async {
    final picked = await _pickDate(
      _values.recurUntil,
      first: _values.date ?? DateTime.now(),
    );
    if (picked == null || !mounted) return;
    _update(() => _values.recurUntil = picked);
  }

  Future<void> _chooseTime(String which) async {
    final current = switch (which) {
      'start' => _values.start,
      'end' => _values.end,
      _ => _values.meet,
    };
    final picked = await _pickTime(current, fallback: _values.start);
    if (picked == null || !mounted) return;
    _update(() {
      switch (which) {
        case 'start':
          _values.start = picked;
        case 'end':
          _values.end = picked;
        default:
          _values.meet = picked;
      }
    });
  }

  // --- Versturen -----------------------------------------------------------

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    _values
      ..title = _title.text
      ..venue = _venue.text
      ..notes = _notes.text
      ..opponent = _opponent.text;

    final String? localError;
    if (!_values.hasStart) {
      localError = l10n.scheduleStartRequired;
    } else if (!_isEdit &&
        _values.type == ScheduleType.training &&
        _values.recurring &&
        _values.recurUntil == null) {
      localError = l10n.scheduleRecurUntilRequired;
    } else {
      localError = null;
    }
    if (localError != null) {
      unawaited(Haptics.error());
      setState(() => _localError = localError);
      return;
    }

    final draft = _values.toDraft(
      teamName: _options.teamName,
      isEdit: _isEdit,
      originalType: _event?.scheduleType,
    );
    if (draft == null) return;

    setState(() {
      _busy = true;
      _validation = null;
      _localError = null;
    });
    final outcome = await widget.onSubmit(draft);
    if (!mounted) return;
    final result = outcome.result;
    if (result != null) {
      setState(() => _busy = false);
      widget.onSaved(result);
      return;
    }
    final error = outcome.error;
    setState(() {
      _busy = false;
      _validation = error is ValidationException ? error : null;
    });
    if (error is ValidationException) {
      unawaited(Haptics.error());
      if (error.errors.isEmpty) {
        setState(() => _localError = scheduleErrorText(l10n, error));
      }
    } else {
      showScheduleError(context, l10n.scheduleSaveFailed, error);
    }
  }

  // --- Opbouw --------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final type = _values.type;
    final match = type == ScheduleType.match;
    final enabled = !_busy;
    final canFollowing = _values.canApplyToFollowing(
      isEdit: _isEdit,
      originalType: _event?.scheduleType,
    );
    final dateText = _values.date == null
        ? null
        : DateFormat('EEEE d MMMM y', 'nl').format(_values.date!);
    String? clock(ClockTime? time) =>
        time == null ? null : formatClockTime(time);

    const gap = SizedBox(height: 16);

    final children = <Widget>[
      if (_localError != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            _localError!,
            key: const ValueKey('schedule-form-error'),
            style: const TextStyle(fontSize: 14, color: StatusColors.red600),
          ),
        ),
      ScheduleFieldLabel(l10n.scheduleTypeLabel),
      ScheduleSegmented<ScheduleType>(
        keyPrefix: 'schedule-type',
        keyOf: (v) => v.apiValue,
        selected: type,
        onChanged: enabled ? (v) => _update(() => _values.type = v) : null,
        segments: [
          for (final v in _options.knownTypes)
            ScheduleSegment(
              value: v,
              label: _options.typeLabel(v),
              icon: scheduleTypeIcon(v),
            ),
        ],
      ),
      ScheduleFieldError(_fieldError('type')),
      gap,
      SchedulePickerField(
        key: const ValueKey('schedule-date'),
        label: l10n.scheduleDateLabel,
        icon: PhosphorIconsRegular.calendarBlank,
        value: dateText,
        placeholder: l10n.schedulePickDate,
        error: _fieldError('starts_at'),
        onTap: enabled ? _chooseDate : null,
      ),
      gap,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SchedulePickerField(
              key: const ValueKey('schedule-start'),
              label: l10n.scheduleStartLabel,
              icon: PhosphorIconsRegular.clock,
              value: clock(_values.start),
              placeholder: l10n.schedulePickTime,
              onTap: enabled ? () => _chooseTime('start') : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SchedulePickerField(
              key: const ValueKey('schedule-end'),
              label: l10n.scheduleEndLabel,
              icon: PhosphorIconsRegular.clock,
              value: clock(_values.end),
              placeholder: l10n.schedulePickTime,
              error: _fieldError('ends_at'),
              clearLabel: l10n.scheduleClearTime,
              onClear: enabled ? () => _update(() => _values.end = null) : null,
              onTap: enabled ? () => _chooseTime('end') : null,
            ),
          ),
        ],
      ),
      if (match) ...[
        gap,
        SchedulePickerField(
          key: const ValueKey('schedule-meet'),
          label: l10n.scheduleMeetLabel,
          icon: PhosphorIconsRegular.usersThree,
          value: clock(_values.meet),
          placeholder: l10n.schedulePickTime,
          error: _fieldError('meet_at'),
          clearLabel: l10n.scheduleClearTime,
          onClear: enabled ? () => _update(() => _values.meet = null) : null,
          onTap: enabled ? () => _chooseTime('meet') : null,
        ),
      ],
      gap,
      ScheduleFieldLabel(l10n.scheduleVenueLabel),
      TextField(
        key: const ValueKey('schedule-venue'),
        controller: _venue,
        enabled: enabled,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: [LengthLimitingTextInputFormatter(scheduleVenueMax)],
        decoration: InputDecoration(
          hintText: l10n.scheduleVenueHint,
          errorText: _fieldError('venue'),
        ),
      ),
      if (match) ...[
        gap,
        ScheduleFieldLabel(l10n.scheduleOurTeam),
        Container(
          key: const ValueKey('schedule-team-name'),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: t.raised,
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            border: Border.all(color: t.line),
          ),
          child: Text(
            _options.teamName,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: t.inkSoft,
            ),
          ),
        ),
        gap,
        ScheduleFieldLabel(l10n.scheduleWePlay),
        ScheduleSegmented<bool>(
          keyPrefix: 'schedule-home',
          selected: _values.isHome,
          onChanged: enabled ? (v) => _update(() => _values.isHome = v) : null,
          segments: [
            ScheduleSegment(value: true, label: l10n.scheduleHome),
            ScheduleSegment(value: false, label: l10n.scheduleAway),
          ],
        ),
        if (_options.competitions.isNotEmpty) ...[
          gap,
          ScheduleFieldLabel(l10n.scheduleCompetitionLabel),
          ScheduleSegmented<String>(
            keyPrefix: 'schedule-competition',
            selected: _values.competition,
            onChanged: enabled
                ? (v) => _update(() => _values.competition = v)
                : null,
            segments: [
              for (final c in _options.competitions)
                ScheduleSegment(value: c.value, label: c.label),
            ],
          ),
          ScheduleFieldError(_fieldError('competition')),
        ],
        gap,
        ScheduleFieldLabel(l10n.scheduleOpponentLabel),
        TextField(
          key: const ValueKey('schedule-opponent'),
          controller: _opponent,
          enabled: enabled,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [LengthLimitingTextInputFormatter(scheduleTeamMax)],
          decoration: InputDecoration(
            hintText: l10n.scheduleOpponentHint,
            errorText:
                _fieldError(_values.isHome ? 'away_team' : 'home_team') ??
                _fieldError('away_team') ??
                _fieldError('home_team'),
          ),
        ),
      ] else ...[
        gap,
        ScheduleFieldLabel(
          type == ScheduleType.activity
              ? l10n.scheduleNameLabel
              : l10n.scheduleTitleLabel,
        ),
        TextField(
          key: const ValueKey('schedule-title'),
          controller: _title,
          enabled: enabled,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: [LengthLimitingTextInputFormatter(scheduleTitleMax)],
          decoration: InputDecoration(
            hintText: type == ScheduleType.activity
                ? l10n.scheduleActivityHint
                : _options.typeLabel(ScheduleType.training),
            errorText: _fieldError('title'),
          ),
        ),
      ],
      gap,
      ScheduleFieldLabel(l10n.scheduleNotesLabel),
      TextField(
        key: const ValueKey('schedule-notes'),
        controller: _notes,
        enabled: enabled,
        minLines: 3,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: [LengthLimitingTextInputFormatter(scheduleNotesMax)],
        decoration: InputDecoration(
          hintText: l10n.scheduleNotesHint,
          errorText: _fieldError('notes'),
        ),
      ),
      if (!_isEdit && type == ScheduleType.training) ...[
        gap,
        ScheduleToggleCard(
          key: const ValueKey('schedule-recur-card'),
          switchKey: const ValueKey('schedule-recurring'),
          icon: PhosphorIconsDuotone.repeat,
          title: l10n.scheduleRecurTitle,
          body: l10n.scheduleRecurBody,
          value: _values.recurring,
          onChanged: enabled
              ? (v) => _update(() => _values.recurring = v)
              : null,
          child: SchedulePickerField(
            key: const ValueKey('schedule-recur-until'),
            label: l10n.scheduleRecurUntil,
            icon: PhosphorIconsRegular.calendarBlank,
            value: _values.recurUntil == null
                ? null
                : DateFormat('EEEE d MMMM y', 'nl').format(_values.recurUntil!),
            placeholder: l10n.schedulePickDate,
            error: _fieldError('recur_until'),
            onTap: enabled ? _chooseRecurUntil : null,
          ),
        ),
      ],
      if (type == ScheduleType.activity) ...[
        gap,
        ScheduleToggleCard(
          switchKey: const ValueKey('schedule-spectators'),
          icon: PhosphorIconsDuotone.binoculars,
          title: l10n.scheduleSpectatorsTitle,
          body: l10n.scheduleSpectatorsBody,
          value: _values.spectatorsCanRsvp,
          onChanged: enabled
              ? (v) => _update(() => _values.spectatorsCanRsvp = v)
              : null,
        ),
      ],
      if (canFollowing) ...[
        gap,
        ScheduleFieldLabel(l10n.scheduleAppliesTo),
        ScheduleSegmented<bool>(
          keyPrefix: 'schedule-following',
          selected: _values.applyToFollowing,
          onChanged: enabled
              ? (v) => _update(() => _values.applyToFollowing = v)
              : null,
          segments: [
            ScheduleSegment(value: false, label: l10n.scheduleOnlyThis),
            ScheduleSegment(value: true, label: l10n.scheduleAlsoFollowing),
          ],
        ),
        if (_values.applyToFollowing && _event != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              l10n.scheduleFollowingHint(_seriesSlot(l10n, _event!)),
              key: const ValueKey('schedule-following-hint'),
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
      ],
      const SizedBox(height: 24),
      PrimaryButton(
        key: const ValueKey('schedule-submit'),
        label: _isEdit ? l10n.scheduleSave : l10n.scheduleCreate,
        expand: true,
        loading: _busy,
        onPressed: enabled ? _submit : null,
      ),
    ];

    return Column(
      key: const ValueKey('schedule-form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  /// `dinsdag om 19:30`: de dag en tijd van de reeks.
  static String _seriesSlot(AppLocalizations l10n, ScheduleEvent event) {
    final starts = event.startsAt.toLocal();
    return l10n.scheduleSlot(
      DateFormat('EEEE', 'nl').format(starts),
      formatClockTime((hour: starts.hour, minute: starts.minute)),
    );
  }
}
