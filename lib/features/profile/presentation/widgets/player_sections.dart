import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/profile_models.dart';
import 'profile_ui.dart';

/// "Ben je geblesseerd?" met een schakelaar (alleen met feature `injuries`
/// en een eigen speler). Rood getint zolang je geblesseerd staat.
class InjuryCard extends StatelessWidget {
  const InjuryCard({super.key, required this.injured, required this.onChanged});

  final bool injured;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final tint = dark ? const Color(0x26EF4444) : StatusColors.red50;
    return AppCard(
      key: const ValueKey('profile-injury'),
      color: injured ? tint : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ProfileCardHeader(
              icon: PhosphorIconsDuotone.ambulance,
              iconColor: StatusColors.red500,
              title: injured
                  ? l10n.profileInjuryActive
                  : l10n.profileInjuryQuestion,
              titleColor: injured
                  ? (dark ? const Color(0xFFFECACA) : const Color(0xFF7F1D1D))
                  : null,
              body: l10n.profileInjuryBody,
            ),
          ),
          const SizedBox(width: 12),
          Semantics(
            label: l10n.profileInjuryLabel,
            child: Switch.adaptive(
              key: const ValueKey('profile-injury-switch'),
              value: injured,
              activeTrackColor: StatusColors.red500,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Vakanties (overzicht); een tik op de kaart opent het vakantiescherm.
class VacationsCard extends StatelessWidget {
  const VacationsCard({super.key, required this.vacations});

  final List<ProfileVacation> vacations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return AppCard(
      key: const ValueKey('profile-vacations'),
      onTap: () => _openEditor(context, AppRoutes.vacations),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileCardHeader(
            icon: PhosphorIconsDuotone.island,
            title: l10n.profileVacationsTitle,
            body: l10n.profileVacationsBody,
          ),
          const SizedBox(height: 12),
          if (vacations.isEmpty)
            Text(
              l10n.profileVacationsEmpty,
              style: TextStyle(fontSize: 14, color: t.muted),
            )
          else
            for (final (index, vacation) in vacations.indexed) ...[
              if (index > 0) Divider(height: 1, color: t.lineSoft),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text.rich(
                  key: ValueKey('profile-vacation-${vacation.id}'),
                  TextSpan(
                    text: l10n.profileVacationRange(
                      formatProfileDate(vacation.startsOn),
                      formatProfileDate(vacation.endsOn),
                    ),
                    style: TextStyle(fontSize: 14, color: t.ink),
                    children: [
                      if (vacation.note case final note?
                          when note.trim().isNotEmpty)
                        TextSpan(
                          text: '  · $note',
                          style: TextStyle(color: t.muted),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          const SizedBox(height: 4),
          const _EditHint(key: ValueKey('profile-vacations-edit')),
        ],
      ),
    );
  }
}

/// Vaste dagen dat je niet kunt, als rij dagpillen; een tik op de kaart opent
/// het scherm Vaste afwezigheid.
class StandingAbsencesCard extends StatelessWidget {
  const StandingAbsencesCard({super.key, required this.absences});

  final StandingAbsences absences;

  static const _names = ['ma', 'di', 'wo', 'do', 'vr', 'za', 'zo'];

  /// `ma` … `zo` voor een ISO-weekdag (0 telt als zondag).
  static String dayName(int weekday) {
    final iso = weekday == 0 ? 7 : weekday;
    return iso >= 1 && iso <= 7 ? _names[iso - 1] : '$weekday';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      key: const ValueKey('profile-standing'),
      onTap: () => _openEditor(context, AppRoutes.standingAbsences),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileCardHeader(
            icon: PhosphorIconsDuotone.calendarX,
            title: l10n.profileStandingTitle,
            body: l10n.profileStandingBody,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final weekday in absences.choices)
                _DayPill(
                  key: ValueKey('profile-standing-$weekday'),
                  label: dayName(weekday),
                  on: absences.isAbsentOn(weekday),
                ),
            ],
          ),
          const SizedBox(height: 8),
          const _EditHint(key: ValueKey('profile-standing-edit')),
        ],
      ),
    );
  }
}

/// Opent het bewerkscherm [route] boven de Mij-tab.
void _openEditor(BuildContext context, String route) {
  unawaited(Haptics.light());
  unawaited(context.push(route));
}

/// "Aanpassen ›" onderaan een tikbare kaart (de hele kaart opent het
/// bewerkscherm; deze regel maakt dat zichtbaar). Bewust net zo klein als de
/// oude "via assistje.nl"-regel, zodat de kaart even hoog blijft.
class _EditHint extends StatelessWidget {
  const _EditHint({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppLocalizations.of(context).profileEditAbsences,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: t.primary,
          ),
        ),
        const SizedBox(width: 2),
        Icon(PhosphorIconsBold.caretRight, size: 12, color: t.primary),
      ],
    );
  }
}

class _DayPill extends StatelessWidget {
  const _DayPill({super.key, required this.label, required this.on});

  final String label;
  final bool on;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      selected: on,
      child: Container(
        width: 44,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: on ? StatusColors.red600 : t.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: on ? StatusColors.red600 : t.line),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: on ? Colors.white : t.inkSoft,
          ),
        ),
      ),
    );
  }
}

/// Je spelersprofiel in dit team: actief (met loslaten) of "Speel je mee?"
/// (met aanmaken).
class PlayerProfileCard extends StatelessWidget {
  const PlayerProfileCard({
    super.key,
    required this.player,
    required this.positionLabel,
    required this.onActivate,
    required this.onRemove,
  });

  final OwnPlayer? player;
  final String? Function(String? code) positionLabel;
  final VoidCallback onActivate;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final player = this.player;

    if (player == null) {
      return AppCard(
        key: const ValueKey('profile-player-join'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCardHeader(
              title: l10n.profilePlayerJoinTitle,
              body: l10n.profilePlayerJoinBody,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              key: const ValueKey('profile-player-activate'),
              label: l10n.profilePlayerActivate,
              onPressed: onActivate,
            ),
          ],
        ),
      );
    }

    final shirt = player.shirtNumber;
    return AppCard(
      key: const ValueKey('profile-player'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCardHeader(
            title: l10n.profilePlayerActive,
            body: l10n.profilePlayerActiveBody,
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              text: positionLabel(player.position) ?? '',
              style: TextStyle(fontSize: 14, color: t.inkSoft),
              children: [
                if (shirt != null)
                  TextSpan(
                    text: '  · ${l10n.profilePlayerShirtNumber(shirt)}',
                    style: TextStyle(color: t.muted),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              key: const ValueKey('profile-player-remove'),
              onPressed: onRemove,
              style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
              child: Text(l10n.profilePlayerRemove),
            ),
          ),
        ],
      ),
    );
  }
}

/// Wat het aanmaakformulier oplevert.
typedef PlayerDraft = ({String position, int? shirtNumber});

/// Opent de sheet "Speler-profiel aanmaken": positie (uit het sportprofiel;
/// zonder lijst een vrij veld) en een optioneel rugnummer. [onSubmit] geeft
/// de fout terug of `null`; de sheet sluit met `true` na een gelukte
/// aanroep.
Future<bool?> showAttachPlayerSheet(
  BuildContext context, {
  required Map<String, String> positions,
  required Future<Object?> Function(PlayerDraft draft) onSubmit,
}) => showAppSheet<bool>(
  context: context,
  title: AppLocalizations.of(context).profilePlayerCreateTitle,
  scrollable: true,
  builder: (context) =>
      _AttachPlayerForm(positions: positions, onSubmit: onSubmit),
);

class _AttachPlayerForm extends StatefulWidget {
  const _AttachPlayerForm({required this.positions, required this.onSubmit});

  final Map<String, String> positions;
  final Future<Object?> Function(PlayerDraft draft) onSubmit;

  @override
  State<_AttachPlayerForm> createState() => _AttachPlayerFormState();
}

class _AttachPlayerFormState extends State<_AttachPlayerForm> {
  final _shirt = TextEditingController();
  final _freePosition = TextEditingController();
  String? _position;
  String? _positionError;
  String? _shirtError;
  Object? _error;
  bool _busy = false;

  @override
  void dispose() {
    _shirt.dispose();
    _freePosition.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final position = widget.positions.isEmpty
        ? _freePosition.text.trim().toUpperCase()
        : _position;
    final shirtText = _shirt.text.trim();
    final shirt = shirtText.isEmpty ? null : int.tryParse(shirtText);
    final positionError = position == null || position.isEmpty
        ? l10n.profilePlayerPositionRequired
        : null;
    final shirtError =
        shirtText.isNotEmpty && (shirt == null || shirt < 1 || shirt > 99)
        ? l10n.profilePlayerShirtInvalid
        : null;
    if (positionError != null || shirtError != null) {
      unawaited(Haptics.error());
      setState(() {
        _positionError = positionError;
        _shirtError = shirtError;
      });
      return;
    }
    setState(() {
      _busy = true;
      _positionError = null;
      _shirtError = null;
      _error = null;
    });
    final error = await widget.onSubmit((
      position: position!,
      shirtNumber: shirt,
    ));
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error;
    });
    // Veldfouten staan al bij het veld; al het andere als toast.
    if (profileFieldError(error, 'position') == null &&
        profileFieldError(error, 'shirt_number') == null) {
      showProfileError(context, l10n.profileSaveFailed, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final positionError =
        _positionError ?? profileFieldError(_error, 'position');
    final shirtError = _shirtError ?? profileFieldError(_error, 'shirt_number');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.profilePlayerPosition,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: t.inkSoft,
            ),
          ),
          const SizedBox(height: 8),
          if (widget.positions.isEmpty)
            TextField(
              key: const ValueKey('profile-player-position-free'),
              controller: _freePosition,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: l10n.profilePlayerPositionHint,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final MapEntry(key: code, value: label)
                    in widget.positions.entries)
                  ChoiceChip(
                    key: ValueKey('profile-player-position-$code'),
                    label: Text('$label ($code)'),
                    selected: _position == code,
                    onSelected: (_) {
                      unawaited(Haptics.selection());
                      setState(() => _position = code);
                    },
                  ),
              ],
            ),
          if (positionError != null) ...[
            const SizedBox(height: 4),
            Text(
              positionError,
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ],
          const SizedBox(height: 16),
          TextField(
            key: const ValueKey('profile-player-shirt'),
            controller: _shirt,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            decoration: InputDecoration(
              hintText: l10n.profilePlayerShirt,
              errorText: shirtError,
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            key: const ValueKey('profile-player-save'),
            label: l10n.profileSave,
            expand: true,
            loading: _busy,
            onPressed: _busy ? null : _submit,
          ),
          TextButton(
            onPressed: _busy ? null : () => Navigator.of(context).pop(false),
            child: Text(l10n.profileCancel),
          ),
        ],
      ),
    );
  }
}
