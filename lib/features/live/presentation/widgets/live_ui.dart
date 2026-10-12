import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/live_models.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String liveErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// Fouttoast (met trilling).
void showLiveError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: liveErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Hoe de delen van de sport heten, uit `rules.periods`: het enkelvoud in
/// kleine letters ("helft", "kwart"), en hoe de pauze heet (met twee delen
/// is dat rust, anders pauze — zoals `MatchClockControls` in de PWA).
class LivePeriodNames {
  const LivePeriodNames({
    required this.part,
    required this.breakLabel,
    required this.count,
    required this.minutes,
  });

  factory LivePeriodNames.of(AppLocalizations l10n, LiveRules rules) {
    final periods = rules.periods;
    final count = periods?.count ?? 1;
    return LivePeriodNames(
      part: (periods?.label ?? '').toLowerCase(),
      breakLabel: count == 2 ? l10n.liveBreak : l10n.livePause,
      count: count,
      minutes: periods?.minutes,
    );
  }

  /// "helft", "kwart"; leeg als de sport geen delen kent.
  final String part;
  final String breakLabel;
  final int count;
  final int? minutes;

  /// Volle speeltijd, of `null` bij een sport die niet op tijd speelt.
  int? get fullTime => minutes == null ? null : count * minutes!;
}

/// Kleur van een kaart, op de soort uit de API (geel, rood, groen); een
/// onbekende soort wordt grijs.
Color liveCardColor(String type) => switch (type) {
  'yellow' => StatusColors.amber400,
  'red' => StatusColors.red500,
  'green' => StatusColors.emerald500,
  _ => const Color(0xFF9CA3AF),
};

/// Vraagt bevestiging in een sheet; `true` als de gebruiker bevestigt.
Future<bool> confirmLive(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final ok = await showAppSheet<bool>(
    context: context,
    title: title,
    builder: (sheetContext) {
      final l10n = AppLocalizations.of(sheetContext);
      final t = AssistjeTokens.of(sheetContext);
      return Column(
        key: const ValueKey('live-confirm'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(message, style: TextStyle(fontSize: 15, color: t.inkSoft)),
          const SizedBox(height: 20),
          if (destructive)
            AppButtonBase(
              key: const ValueKey('live-confirm-ok'),
              label: confirmLabel,
              onPressed: () => Navigator.of(sheetContext).pop(true),
              background: StatusColors.red600,
              foreground: Colors.white,
              expand: true,
            )
          else
            PrimaryButton(
              key: const ValueKey('live-confirm-ok'),
              label: confirmLabel,
              onPressed: () => Navigator.of(sheetContext).pop(true),
              expand: true,
            ),
          const SizedBox(height: 8),
          SecondaryButton(
            key: const ValueKey('live-confirm-cancel'),
            label: l10n.liveCancel,
            onPressed: () => Navigator.of(sheetContext).pop(false),
            expand: true,
          ),
        ],
      );
    },
  );
  return ok ?? false;
}

/// Een klein getalveld voor een minuut (0–[max]).
class LiveMinuteField extends StatefulWidget {
  const LiveMinuteField({
    super.key,
    required this.value,
    required this.onChanged,
    this.max = 120,
    this.min = 0,
    this.width = 88,
    this.label,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int max;
  final int min;
  final double width;
  final String? label;

  @override
  State<LiveMinuteField> createState() => _LiveMinuteFieldState();
}

class _LiveMinuteFieldState extends State<LiveMinuteField> {
  late final TextEditingController _controller = TextEditingController(
    text: '${widget.value}',
  );

  @override
  void didUpdateWidget(LiveMinuteField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final parsed = int.tryParse(_controller.text);
    if (parsed != widget.value && oldWidget.value != widget.value) {
      _controller.text = '${widget.value}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return SizedBox(
      width: widget.width,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: t.ink,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
        decoration: InputDecoration(
          isDense: true,
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          ),
        ),
        onChanged: (text) {
          final value = int.tryParse(text) ?? widget.min;
          widget.onChanged(value.clamp(widget.min, widget.max));
        },
      ),
    );
  }
}

/// Een amber meldingsvlak (aftrap voorbij, klok doorgelopen).
class LiveNotice extends StatelessWidget {
  const LiveNotice({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final fg = dark ? StatusColors.amber300 : StatusColors.amber800;
    final bg = dark ? const Color(0x26F59E0B) : StatusColors.amber50;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.timer_outlined, size: 16, color: fg),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    color: fg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
