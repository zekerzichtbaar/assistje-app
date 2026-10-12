import 'package:freezed_annotation/freezed_annotation.dart';

/// Lenient lezers voor getallen en teksten uit de statistiek-API: een SQL-som
/// kan als tekst of float binnenkomen, en een ontbrekend veld mag de hele
/// lijst niet laten vallen.

/// Een geheel getal uit `int`, `double` of numerieke tekst; anders 0.
int readInt(Object? value) => switch (value) {
  final int v => v,
  final num v => v.round(),
  final String v => num.tryParse(v)?.round() ?? 0,
  _ => 0,
};

/// Een getal (bv. een percentage) uit `num` of numerieke tekst; anders 0.
double readDouble(Object? value) => switch (value) {
  final num v => v.toDouble(),
  final String v => double.tryParse(v) ?? 0,
  _ => 0,
};

/// Een optioneel geheel getal: `null` blijft `null`.
int? readIntOrNull(Object? value) => value == null ? null : readInt(value);

/// Een tekst uit tekst of getal; `null` (of leeg) blijft `null`.
String? readStringOrNull(Object? value) => switch (value) {
  null => null,
  final String v => v.isEmpty ? null : v,
  final Object v => v.toString(),
};

/// `@asInt @Default(0) int goals` — lenient geheel getal.
const asInt = JsonKey(fromJson: readInt);

/// `@asDouble @Default(0) double rate` — lenient getal.
const asDouble = JsonKey(fromJson: readDouble);

/// `@asIntOrNull int? shirtNumber` — lenient optioneel geheel getal.
const asIntOrNull = JsonKey(fromJson: readIntOrNull);

/// `@asStringOrNull String? value` — tekst of getal als tekst.
const asStringOrNull = JsonKey(fromJson: readStringOrNull);
