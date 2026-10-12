import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../fines/application/money.dart';
import '../application/savings_controller.dart';
import '../data/models/savings_models.dart';
import '../data/savings_repository.dart';
import 'widgets/savings_ui.dart';

/// Hoogste bedrag per maand/persoon (`amount` max 100000 euro).
const int maxSavingsAmountCents = 10000000;

/// "Nieuwe spaarpot" / "Pot bewerken" (`Pages/Savings/Form` in de PWA).
///
/// Laadt de keuzelijsten (`create`, of bij [potId] `edit` met de huidige
/// waarden). [onSubmit] doet het verzoek en geeft de fout terug; bij succes
/// sluit het scherm met `true`. Een 422 blijft in het formulier staan.
class SavingsFormScreen extends ConsumerWidget {
  const SavingsFormScreen({
    super.key,
    required this.teamId,
    required this.onSubmit,
    this.potId,
    this.eventId,
    this.today,
  });

  final int teamId;
  final int? potId;

  /// Een activiteit om voor te zetten (`?event=`), alleen bij nieuw.
  final int? eventId;
  final Future<Object?> Function(SavingsPotDraft draft) onSubmit;

  /// Voor tests: "nu" (standaard startmaand).
  final DateTime? today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final query = (teamId: teamId, potId: potId, eventId: eventId);
    final async = ref.watch(savingsFormOptionsProvider(query));
    final options = async.value;

    final Widget body;
    if (options != null) {
      body = _SavingsForm(
        options: options,
        onSubmit: onSubmit,
        today: today ?? DateTime.now(),
      );
    } else if (async.hasError) {
      body = ListView(
        padding: const EdgeInsets.all(12),
        children: [
          EmptyState(
            key: const ValueKey('savings-form-load-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.savingsFormLoadError,
            description: savingsLoadErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('savings-form-retry'),
              label: l10n.retry,
              onPressed: () =>
                  ref.invalidate(savingsFormOptionsProvider(query)),
            ),
          ),
        ],
      );
    } else {
      body = const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          key: ValueKey('savings-form-loading'),
          children: [
            Skeleton(height: 220, radius: AssistjeTokens.radius2xl),
            SizedBox(height: 12),
            Skeleton(height: 160, radius: AssistjeTokens.radius2xl),
          ],
        ),
      );
    }

    return Scaffold(
      key: const ValueKey('savings-form-screen'),
      backgroundColor: t.sunken,
      appBar: AppBar(
        backgroundColor: t.sunken,
        title: Text(
          potId == null ? l10n.savingsFormNewTitle : l10n.savingsFormEditTitle,
        ),
      ),
      body: SafeArea(top: false, child: body),
    );
  }
}

class _SavingsForm extends StatefulWidget {
  const _SavingsForm({
    required this.options,
    required this.onSubmit,
    required this.today,
  });

  final SavingsFormOptions options;
  final Future<Object?> Function(SavingsPotDraft draft) onSubmit;
  final DateTime today;

  @override
  State<_SavingsForm> createState() => _SavingsFormState();
}

class _SavingsFormState extends State<_SavingsForm> {
  late final TextEditingController _name;
  late final TextEditingController _amount;
  late final TextEditingController _goal;
  late final TextEditingController _months;
  late SavingsScope _scope;
  late bool _includeGuests;
  late String _startMonth;
  late Set<String> _members;
  int? _eventId;
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  /// Laatst gekozen aantal maanden bij "Per maand" (terug van "Eenmalig").
  String _lastMonths = '11';

  List<SavingsEvent> get _activities => widget.options.activities;

  SavingsEvent? get _linked {
    final id = _eventId;
    if (id == null) return null;
    for (final a in _activities) {
      if (a.id == id) return a;
    }
    return null;
  }

  bool get _oneOff => _months.text.trim() == '1';

  @override
  void initState() {
    super.initState();
    final pot = widget.options.pot;
    SavingsEvent? preset;
    if (pot == null && widget.options.presetEventId != null) {
      for (final a in _activities) {
        if (a.id == widget.options.presetEventId) preset = a;
      }
    }
    _name = TextEditingController(text: pot?.name ?? preset?.title ?? '');
    _amount = TextEditingController(
      text: pot == null ? '' : centsToInput((pot.amount * 100).round()),
    );
    final goal = pot?.goal;
    _goal = TextEditingController(
      text: goal == null ? '' : centsToInput((goal * 100).round()),
    );
    _months = TextEditingController(
      text: pot != null
          ? '${pot.months}'
          : preset != null
          ? '1'
          : '11',
    );
    _scope =
        pot?.scope ?? (preset != null ? SavingsScope.event : SavingsScope.all);
    if (_scope == SavingsScope.unknown) _scope = SavingsScope.all;
    _includeGuests = pot?.includeGuests ?? false;
    final presetStart = preset?.startsAt;
    _startMonth =
        pot?.startMonth ??
        (presetStart != null
            ? ymOf(presetStart.toLocal())
            : ymOf(widget.today));
    if (parseYm(_startMonth) == null) _startMonth = ymOf(widget.today);
    _members = {...?pot?.members};
    _eventId = pot?.eventId ?? preset?.id;
  }

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    _goal.dispose();
    _months.dispose();
    super.dispose();
  }

  int? get _amountCents {
    final cents = parseEuroToCents(_amount.text);
    if (cents == null || cents <= 0 || cents > maxSavingsAmountCents) {
      return null;
    }
    return cents;
  }

  /// `null` = leeg (geen doel); `-1` = ongeldig.
  int? get _goalCents {
    if (_goal.text.trim().isEmpty) return null;
    final cents = parseEuroToCents(_goal.text);
    return cents == null || cents < 0 ? -1 : cents;
  }

  int? get _monthsValue {
    final months = int.tryParse(_months.text.trim());
    return months == null || months < 1 || months > 60 ? null : months;
  }

  void _setOneOff(bool on) {
    Haptics.selection();
    setState(() {
      if (on) {
        if (!_oneOff) _lastMonths = _months.text;
        _months.text = '1';
      } else if (_oneOff) {
        _months.text = _lastMonths == '1' ? '11' : _lastMonths;
      }
    });
  }

  /// Een activiteit kiezen zet de maand en deelnemers mee; loskoppelen haalt
  /// "Aangemeld" weg (die heeft dan geen bron meer).
  void _pickActivity(int? id) {
    SavingsEvent? activity;
    for (final a in _activities) {
      if (a.id == id) activity = a;
    }
    setState(() {
      _eventId = activity?.id;
      final startsAt = activity?.startsAt;
      if (startsAt != null) _startMonth = ymOf(startsAt.toLocal());
      if (activity != null) {
        _scope = SavingsScope.event;
        if (_name.text.trim().isEmpty) _name.text = activity.title;
      } else if (_scope == SavingsScope.event) {
        _scope = SavingsScope.all;
      }
    });
  }

  Future<void> _submit() async {
    setState(() => _tried = true);
    final name = _name.text.trim();
    final amount = _amountCents;
    final months = _monthsValue;
    final goal = _goalCents;
    if (name.isEmpty || amount == null || months == null || goal == -1) {
      unawaited(Haptics.error());
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit(
      SavingsPotDraft(
        name: name,
        scope: _scope,
        includeGuests: _includeGuests,
        amountCents: amount,
        goalCents: goal,
        startMonth: _startMonth,
        months: months,
        members: [
          for (final key in _members)
            if (_isKnownMember(key)) key,
        ],
        eventId: _eventId,
      ),
    );
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    unawaited(Haptics.error());
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  bool _isKnownMember(String key) =>
      widget.options.people.players.any((p) => p.key == key) ||
      widget.options.people.staff.any((s) => s.key == key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final label = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.inkSoft,
    );
    final error = _error;
    final oneOff = _oneOff;
    final linked = _linked;
    final people = widget.options.people;
    final scopes = [
      if (linked != null) SavingsScope.event,
      SavingsScope.all,
      SavingsScope.allStaff,
      SavingsScope.custom,
    ];
    final scope = scopes.contains(_scope) ? _scope : SavingsScope.all;
    final formMessage = savingsFormMessage(l10n, error);

    Widget fieldError(String field) {
      final message = savingsFieldError(error, field);
      if (message == null) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          message,
          key: ValueKey('savings-form-error-$field'),
          style: const TextStyle(fontSize: 13, color: StatusColors.red600),
        ),
      );
    }

    final amountField = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          oneOff ? l10n.savingsFormAmountOneOff : l10n.savingsFormAmountMonthly,
          style: label,
        ),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('savings-form-amount'),
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            prefixText: '€ ',
            hintText: l10n.savingsFormAmountHint,
            errorText: _tried && _amountCents == null
                ? l10n.savingsFormAmountInvalid
                : null,
          ),
        ),
        fieldError('amount'),
      ],
    );

    return ListView(
      key: const ValueKey('savings-form'),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      children: [
        if (formMessage != null)
          SavingsFormError(
            formMessage,
            key: const ValueKey('savings-form-message'),
          ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.savingsFormName, style: label),
              const SizedBox(height: 4),
              TextField(
                key: const ValueKey('savings-form-name'),
                controller: _name,
                maxLength: 80,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: l10n.savingsFormNameHint,
                  errorText: _tried && _name.text.trim().isEmpty
                      ? l10n.savingsFormNameRequired
                      : null,
                ),
              ),
              fieldError('name'),
              const SizedBox(height: 16),
              AppTabPills<bool>(
                key: const ValueKey('savings-form-frequency'),
                fullWidth: true,
                selected: oneOff,
                onChanged: _setOneOff,
                tabs: [
                  AppTabPill(value: false, label: l10n.savingsFormMonthly),
                  AppTabPill(value: true, label: l10n.savingsFormOneOff),
                ],
              ),
              if (_activities.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(l10n.savingsFormActivity, style: label),
                const SizedBox(height: 4),
                DropdownButtonFormField<int?>(
                  key: const ValueKey('savings-form-activity'),
                  initialValue: _eventId,
                  isExpanded: true,
                  onChanged: _busy ? null : _pickActivity,
                  items: [
                    DropdownMenuItem<int?>(
                      child: Text(l10n.savingsFormNoActivity),
                    ),
                    for (final a in _activities)
                      DropdownMenuItem<int?>(
                        value: a.id,
                        child: Text(
                          _activityLabel(l10n, a),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
                fieldError('event_id'),
              ],
              const SizedBox(height: 16),
              if (oneOff)
                amountField
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: amountField),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(l10n.savingsFormMonths, style: label),
                          const SizedBox(height: 4),
                          TextField(
                            key: const ValueKey('savings-form-months'),
                            controller: _months,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              errorText: _tried && _monthsValue == null
                                  ? l10n.savingsFormMonthsInvalid
                                  : null,
                            ),
                          ),
                          fieldError('months'),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              Text(
                oneOff ? l10n.savingsFormMonth : l10n.savingsFormStartMonth,
                style: label,
              ),
              const SizedBox(height: 4),
              _MonthPicker(
                ym: _startMonth,
                enabled: !_busy,
                onChanged: (ym) => setState(() => _startMonth = ym),
              ),
              fieldError('start_month'),
              const SizedBox(height: 16),
              Text(l10n.savingsFormGoal, style: label),
              const SizedBox(height: 4),
              TextField(
                key: const ValueKey('savings-form-goal'),
                controller: _goal,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixText: '€ ',
                  hintText: '—',
                  errorText: _tried && _goalCents == -1
                      ? l10n.savingsFormGoalInvalid
                      : null,
                ),
              ),
              fieldError('goal'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.savingsFormParticipants.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: t.muted,
                ),
              ),
              const SizedBox(height: 12),
              // Pills die doorlopen naar een volgende regel: vier keuzes
              // passen niet altijd naast elkaar.
              Wrap(
                key: const ValueKey('savings-form-scope'),
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in scopes)
                    AppPill(
                      key: ValueKey('savings-form-scope-${s.apiValue}'),
                      label: _scopeLabel(l10n, s),
                      selected: s == scope,
                      onTap: () {
                        Haptics.selection();
                        setState(() => _scope = s);
                      },
                    ),
                ],
              ),
              fieldError('scope'),
              const SizedBox(height: 12),
              if (scope == SavingsScope.custom) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in people.players)
                      AppPill(
                        key: ValueKey('savings-form-member-${p.key}'),
                        label: p.shirtNumber == null
                            ? p.name
                            : '${p.shirtNumber}  ${p.name}',
                        selected: _members.contains(p.key),
                        onTap: () => _toggleMember(p.key),
                      ),
                  ],
                ),
                if (people.staff.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    l10n.savingsFormStaff.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: t.muted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final s in people.staff)
                        AppPill(
                          key: ValueKey('savings-form-member-${s.key}'),
                          label: s.name,
                          selected: _members.contains(s.key),
                          onTap: () => _toggleMember(s.key),
                        ),
                    ],
                  ),
                ],
                fieldError('members'),
              ] else ...[
                _InfoBox(
                  key: const ValueKey('savings-form-scope-info'),
                  text: switch (scope) {
                    SavingsScope.event => l10n.savingsFormEventInfo(
                      linked?.title ?? l10n.savingsFormEventFallback,
                    ),
                    SavingsScope.allStaff => l10n.savingsFormAllStaffInfo,
                    _ => l10n.savingsFormAllInfo,
                  },
                ),
                if (scope != SavingsScope.event && people.hasGuests) ...[
                  const SizedBox(height: 12),
                  AppCard(
                    color: t.raised,
                    radius: AssistjeTokens.radiusXl,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.savingsFormGuests,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: t.ink,
                                ),
                              ),
                              Text(
                                l10n.savingsFormGuestsInfo,
                                style: TextStyle(fontSize: 12, color: t.muted),
                              ),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          key: const ValueKey('savings-form-guests'),
                          value: _includeGuests,
                          onChanged: (on) {
                            Haptics.selection();
                            setState(() => _includeGuests = on);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('savings-form-submit'),
          label: widget.options.pot == null
              ? l10n.savingsFormCreate
              : l10n.savingsFormSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _submit,
        ),
      ],
    );
  }

  void _toggleMember(String key) {
    Haptics.selection();
    setState(() {
      if (!_members.remove(key)) _members.add(key);
    });
  }

  static String _activityLabel(AppLocalizations l10n, SavingsEvent a) {
    final startsAt = a.startsAt;
    final date = startsAt == null ? '' : savingsDateLongLabel(startsAt);
    return a.cancelled
        ? l10n.savingsFormActivityCancelled(a.title, date)
        : l10n.savingsFormActivityLabel(a.title, date);
  }
}

/// Label van een scope-keuze.
String _scopeLabel(AppLocalizations l10n, SavingsScope scope) =>
    switch (scope) {
      SavingsScope.all || SavingsScope.unknown => l10n.savingsScopeAll,
      SavingsScope.allStaff => l10n.savingsScopeAllStaff,
      SavingsScope.custom => l10n.savingsScopeCustom,
      SavingsScope.event => l10n.savingsScopeEvent,
    };

/// Maandkiezer: vorige / `november 2026` / volgende.
class _MonthPicker extends StatelessWidget {
  const _MonthPicker({
    required this.ym,
    required this.onChanged,
    required this.enabled,
  });

  final String ym;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return AppCard(
      key: const ValueKey('savings-form-start-month'),
      color: t.raised,
      radius: AssistjeTokens.radiusXl,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        children: [
          IconButton(
            key: const ValueKey('savings-form-month-prev'),
            tooltip: l10n.savingsFormPrevMonth,
            onPressed: enabled
                ? () {
                    Haptics.selection();
                    onChanged(shiftYm(ym, -1));
                  }
                : null,
            icon: Icon(PhosphorIconsBold.caretLeft, size: 18, color: t.inkSoft),
          ),
          Expanded(
            child: Text(
              savingsMonthLong(ym),
              key: const ValueKey('savings-form-month-label'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
            ),
          ),
          IconButton(
            key: const ValueKey('savings-form-month-next'),
            tooltip: l10n.savingsFormNextMonth,
            onPressed: enabled
                ? () {
                    Haptics.selection();
                    onChanged(shiftYm(ym, 1));
                  }
                : null,
            icon: Icon(
              PhosphorIconsBold.caretRight,
              size: 18,
              color: t.inkSoft,
            ),
          ),
        ],
      ),
    );
  }
}

/// Groen uitlegvlak (wie doet er mee).
class _InfoBox extends StatelessWidget {
  const _InfoBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: dark
            ? StatusColors.emerald500.withValues(alpha: 0.15)
            : StatusColors.emerald50,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: dark ? StatusColors.emerald100 : const Color(0xFF064E3B),
        ),
      ),
    );
  }
}
