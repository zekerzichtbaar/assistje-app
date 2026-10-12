import 'package:intl/intl.dart';

/// `€ 2,50` uit 250 cent (nl_NL). Negatief: `€ -12,50`.
String formatCents(int cents) => _euro.format(cents / 100);

/// Met teken ervoor: `+ € 45,00` of `− € 12,50` (potregels).
String formatSignedCents(int cents) {
  if (cents == 0) return formatCents(0);
  final sign = cents > 0 ? '+' : '−';
  return '$sign ${formatCents(cents.abs())}';
}

/// Bedrag zonder valutateken voor een invoerveld: `2,50`.
String centsToInput(int cents) {
  final abs = cents.abs();
  final euros = abs ~/ 100;
  final rest = (abs % 100).toString().padLeft(2, '0');
  return '${cents < 0 ? '-' : ''}$euros,$rest';
}

/// Leest een bedrag zoals een Nederlander het typt (`2,50`, `2.50`, `€ 3`,
/// `1.250,00`) naar centen. `null` als het geen bedrag is of meer dan twee
/// decimalen heeft.
int? parseEuroToCents(String input) {
  var text = input.replaceAll('€', '').replaceAll(RegExp(r'\s'), '');
  if (text.isEmpty) return null;
  var negative = false;
  if (text.startsWith('-') || text.startsWith('−')) {
    negative = true;
    text = text.substring(1);
  }
  final lastComma = text.lastIndexOf(',');
  final lastDot = text.lastIndexOf('.');
  final decimalAt = lastComma > lastDot ? lastComma : lastDot;
  final fractionLength = decimalAt < 0 ? 0 : text.length - decimalAt - 1;
  // Een komma is altijd de decimaalkomma: `2,505` is geen bedrag.
  if (decimalAt == lastComma && decimalAt >= 0 && fractionLength > 2) {
    return null;
  }
  String whole;
  var fraction = '';
  if (decimalAt >= 0 && fractionLength <= 2) {
    whole = text.substring(0, decimalAt);
    fraction = text.substring(decimalAt + 1);
  } else {
    whole = text;
  }
  // Wat links overblijft mag alleen duizendtallen-scheiders bevatten.
  whole = whole.replaceAll('.', '').replaceAll(',', '');
  if (whole.isEmpty) whole = '0';
  if (!RegExp(r'^\d+$').hasMatch(whole) ||
      !RegExp(r'^\d{0,2}$').hasMatch(fraction)) {
    return null;
  }
  final euros = int.parse(whole);
  final cents = int.parse(fraction.padRight(2, '0'));
  final total = euros * 100 + cents;
  return negative ? -total : total;
}

final NumberFormat _euro = NumberFormat.currency(
  locale: 'nl_NL',
  symbol: '€',
  decimalDigits: 2,
);
