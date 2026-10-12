import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/door_scaffold.dart';
import '../../../join/presentation/widgets/join_door.dart';

/// Een e-mailadres dat er als een e-mailadres uitziet (de server
/// valideert het echt).
final RegExp signupEmailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// De tekst voor een fout op het aanmeldscherm. Een Nederlandse zin van de
/// server (422) gaat voor; verbinding, 429 en 5xx krijgen eigen copy.
String signupErrorText(AppLocalizations l10n, Object error) {
  return switch (error) {
    NetworkException() => l10n.signupNetworkError,
    ThrottledException() => l10n.signupThrottled,
    ServerException() => l10n.signupGenericError,
    ApiException(:final message?) when message.isNotEmpty => message,
    _ => l10n.signupGenericError,
  };
}

/// De ISO-weekdagen (1 = maandag) als `(kort, voluit)`.
List<(String, String)> signupDays(AppLocalizations l10n) => [
  (l10n.signupDayShortMon, l10n.signupDayMon),
  (l10n.signupDayShortTue, l10n.signupDayTue),
  (l10n.signupDayShortWed, l10n.signupDayWed),
  (l10n.signupDayShortThu, l10n.signupDayThu),
  (l10n.signupDayShortFri, l10n.signupDayFri),
  (l10n.signupDayShortSat, l10n.signupDaySat),
  (l10n.signupDayShortSun, l10n.signupDaySun),
];

/// Kop van een stap: optioneel een kleine regel erboven (de clubnaam),
/// de vraag en een uitleg.
class SignupHeading extends StatelessWidget {
  const SignupHeading({
    required this.title,
    this.subtitle,
    this.eyebrow,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? eyebrow;

  @override
  Widget build(BuildContext context) {
    final eyebrow = this.eyebrow;
    final subtitle = this.subtitle;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (eyebrow != null && eyebrow.isNotEmpty) ...[
            Text(
              eyebrow,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0x990C120D),
              ),
            ),
            const SizedBox(height: 6),
          ],
          DoorHeadline(title),
          if (subtitle != null && subtitle.isNotEmpty) ...[
            const SizedBox(height: 12),
            DoorSubtitle(subtitle),
          ],
        ],
      ),
    );
  }
}

/// "Stap 2 van 5" met een balk.
class SignupProgress extends StatelessWidget {
  const SignupProgress({required this.step, required this.total, super.key});

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.signupProgress(step, total),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xB30C120D),
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : step / total,
              minHeight: 6,
              color: DoorColors.ink,
              backgroundColor: const Color(0x260C120D),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tekstveld in de deur-stijl met een veldfout eronder.
class SignupField extends StatelessWidget {
  const SignupField({
    required this.controller,
    required this.label,
    this.error,
    this.autofocus = false,
    this.keyboardType,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.suffix,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? error;
  final bool autofocus;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      textCapitalization: textCapitalization,
      autocorrect: autocorrect,
      maxLength: maxLength,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      style: const TextStyle(fontSize: 17, color: DoorColors.ink),
      decoration: doorInputDecoration(
        label: label,
      ).copyWith(errorText: error, errorMaxLines: 3, suffixIcon: suffix),
    );
  }
}

/// Het logo van een club in een vast vak; zonder logo de beginletter.
class SignupClubMark extends StatelessWidget {
  const SignupClubMark({
    required this.name,
    this.logoUrl,
    this.size = 40,
    super.key,
  });

  final String name;
  final String? logoUrl;
  final double size;

  static final RegExp _prefix = RegExp(
    r'^(v\.?v\.?|s\.?v\.?|fc|de)\s+',
    caseSensitive: false,
  );

  @override
  Widget build(BuildContext context) {
    final initial = name.replaceFirst(_prefix, '').trim();
    final letter = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0x0D000000),
        shape: BoxShape.circle,
      ),
      child: Text(
        initial.isEmpty ? '' : initial.characters.first.toUpperCase(),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xB30C120D),
        ),
      ),
    );
    final url = logoUrl;
    if (url == null || url.isEmpty) return letter;
    return SizedBox.square(
      dimension: size,
      child: Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => letter,
      ),
    );
  }
}

/// Een rij in een lijst: wit vlak, tikbaar, met een pijltje.
class SignupChoice extends StatelessWidget {
  const SignupChoice({
    required this.child,
    required this.onTap,
    this.chevron = true,
    super.key,
  });

  final Widget child;
  final VoidCallback onTap;
  final bool chevron;

  @override
  Widget build(BuildContext context) {
    return DoorPanel(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(child: child),
          if (chevron)
            const Icon(Icons.chevron_right_rounded, color: Color(0x660C120D)),
        ],
      ),
    );
  }
}
