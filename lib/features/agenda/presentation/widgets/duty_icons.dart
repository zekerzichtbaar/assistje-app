import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Het icoon van een diensttype (`duty_types.icon`), als duotone.
///
/// De PWA slaat de Phosphor-componentnaam op (`TShirt`), de API-voorbeelden
/// tonen kebab-case (`t-shirt`); beide worden hier genormaliseerd. Legacy-rijen
/// zonder icoon vallen terug op hun `duty_type` (canteen/field/wash), en al het
/// andere op een kalender.
IconData dutyIconFor(String? icon, [String? dutyType]) {
  final key = _normalize(icon) ?? _legacy[_normalize(dutyType)];
  return _icons[key] ?? PhosphorIconsDuotone.calendar;
}

String? _normalize(String? value) {
  if (value == null || value.isEmpty) return null;
  return value.replaceAll(RegExp(r'[-_\s]'), '').toLowerCase();
}

const Map<String?, String> _legacy = {
  'canteen': 'beerstein',
  'field': 'flag',
  'wash': 'tshirt',
  'laundry': 'tshirt',
};

final Map<String, IconData> _icons = {
  'beerstein': PhosphorIconsDuotone.beerStein,
  'coffee': PhosphorIconsDuotone.coffee,
  'forkknife': PhosphorIconsDuotone.forkKnife,
  'orange': PhosphorIconsDuotone.orange,
  'cookie': PhosphorIconsDuotone.cookie,
  'flag': PhosphorIconsDuotone.flag,
  'soccerball': PhosphorIconsDuotone.soccerBall,
  'courtbasketball': PhosphorIconsDuotone.courtBasketball,
  'megaphone': PhosphorIconsDuotone.megaphone,
  'tshirt': PhosphorIconsDuotone.tShirt,
  'washingmachine': PhosphorIconsDuotone.washingMachine,
  'broom': PhosphorIconsDuotone.broom,
  'drop': PhosphorIconsDuotone.drop,
  'trash': PhosphorIconsDuotone.trash,
  'car': PhosphorIconsDuotone.car,
  'bicycle': PhosphorIconsDuotone.bicycle,
  'firstaidkit': PhosphorIconsDuotone.firstAidKit,
  'key': PhosphorIconsDuotone.key,
  'money': PhosphorIconsDuotone.money,
  'ticket': PhosphorIconsDuotone.ticket,
  'toolbox': PhosphorIconsDuotone.toolbox,
  'wrench': PhosphorIconsDuotone.wrench,
  'usersthree': PhosphorIconsDuotone.usersThree,
  'clipboardtext': PhosphorIconsDuotone.clipboardText,
  'camera': PhosphorIconsDuotone.camera,
  'gift': PhosphorIconsDuotone.gift,
  'cake': PhosphorIconsDuotone.cake,
  'confetti': PhosphorIconsDuotone.confetti,
  'calendar': PhosphorIconsDuotone.calendar,
};
