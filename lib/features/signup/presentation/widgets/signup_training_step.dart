import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/door_scaffold.dart';
import '../../../join/presentation/widgets/join_door.dart';
import '../../data/models/signup_models.dart';
import 'signup_widgets.dart';

/// De trainingsdagen: dagknoppen ma–zo, per dag begin/eind en optioneel
/// het veld. Hieruit komt een seizoen trainingen in de agenda.
class SignupTrainingStep extends StatefulWidget {
  const SignupTrainingStep({
    required this.trainings,
    required this.onChanged,
    required this.maxTrainings,
    required this.buttonLabel,
    required this.onContinue,
    this.busy = false,
    this.error,
    super.key,
  });

  final List<SignupTraining> trainings;
  final ValueChanged<List<SignupTraining>> onChanged;
  final int maxTrainings;

  /// "Verder" (er volgt nog een programmastap) of "Maak mijn omgeving".
  final String buttonLabel;
  final VoidCallback onContinue;
  final bool busy;
  final String? error;

  @override
  State<SignupTrainingStep> createState() => _SignupTrainingStepState();
}

class _SignupTrainingStepState extends State<SignupTrainingStep> {
  final Map<int, TextEditingController> _venues = {};

  @override
  void dispose() {
    for (final controller in _venues.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _venue(SignupTraining slot) => _venues.putIfAbsent(
    slot.weekday,
    () => TextEditingController(text: slot.venue),
  );

  void _toggle(int weekday) {
    final slots = widget.trainings;
    if (slots.any((s) => s.weekday == weekday)) {
      widget.onChanged([
        for (final s in slots)
          if (s.weekday != weekday) s,
      ]);
      _venues.remove(weekday)?.dispose();
      return;
    }
    if (slots.length >= widget.maxTrainings) return;
    widget.onChanged(
      [...slots, SignupTraining(weekday: weekday)]
        ..sort((a, b) => a.weekday.compareTo(b.weekday)),
    );
  }

  void _update(int weekday, SignupTraining Function(SignupTraining) change) {
    widget.onChanged([
      for (final s in widget.trainings) s.weekday == weekday ? change(s) : s,
    ]);
  }

  static TimeOfDay _parse(String value) {
    final parts = value.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.first) ?? 19,
      minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
    );
  }

  static String _format(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}';

  Future<void> _pickTime(SignupTraining slot, {required bool start}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _parse(start ? slot.startsAt : slot.endsAt),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;
    _update(
      slot.weekday,
      (s) => start
          ? s.copyWith(startsAt: _format(picked))
          : s.copyWith(endsAt: _format(picked)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = signupDays(l10n);
    final slots = widget.trainings;
    SignupTraining? backwards;
    for (final s in slots) {
      if (s.isBackwards) {
        backwards = s;
        break;
      }
    }
    final message = backwards != null
        ? l10n.signupTrainingBackwards(days[backwards.weekday - 1].$2)
        : widget.error;

    return Column(
      key: const ValueKey('signup-trainings'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: l10n.signupTrainingsTitle,
          subtitle: l10n.signupTrainingsSubtitle,
        ),
        Row(
          children: [
            for (var i = 0; i < 7; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              Expanded(child: _dayButton(i + 1, days[i])),
            ],
          ],
        ),
        const SizedBox(height: 12),
        for (final slot in slots) ...[
          DoorPanel(
            key: ValueKey('signup-slot-${slot.weekday}'),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 84,
                      child: Text(
                        days[slot.weekday - 1].$2,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: _timeButton(
                        key: ValueKey('signup-start-${slot.weekday}'),
                        label: l10n.signupStartLabel(days[slot.weekday - 1].$2),
                        value: slot.startsAt,
                        onTap: () => _pickTime(slot, start: true),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('–'),
                    ),
                    Expanded(
                      child: _timeButton(
                        key: ValueKey('signup-end-${slot.weekday}'),
                        label: l10n.signupEndLabel(days[slot.weekday - 1].$2),
                        value: slot.endsAt,
                        onTap: () => _pickTime(slot, start: false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  key: ValueKey('signup-venue-${slot.weekday}'),
                  controller: _venue(slot),
                  maxLength: 160,
                  onChanged: (value) =>
                      _update(slot.weekday, (s) => s.copyWith(venue: value)),
                  style: const TextStyle(fontSize: 15, color: DoorColors.ink),
                  decoration: doorInputDecoration(label: l10n.signupVenueHint)
                      .copyWith(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (message != null) ...[const SizedBox(height: 4), DoorError(message)],
        const SizedBox(height: 16),
        DoorButton(
          key: const Key('signup-trainings-continue'),
          label: widget.buttonLabel,
          busy: widget.busy,
          onPressed: slots.isEmpty || backwards != null
              ? null
              : widget.onContinue,
        ),
      ],
    );
  }

  Widget _dayButton(int weekday, (String, String) day) {
    final on = widget.trainings.any((s) => s.weekday == weekday);
    return Semantics(
      button: true,
      selected: on,
      label: day.$2,
      excludeSemantics: true,
      child: GestureDetector(
        key: ValueKey('signup-day-$weekday'),
        onTap: () => _toggle(weekday),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 120),
          opacity: on ? 1 : 0.55,
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: on ? DoorColors.action : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: DoorColors.ink, width: 2.5),
            ),
            child: Text(
              day.$1.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: DoorColors.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeButton({
    required Key key,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      label: label,
      value: value,
      excludeSemantics: true,
      child: GestureDetector(
        key: key,
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: DoorColors.paper,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: DoorColors.ink, width: 2),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: DoorColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}
