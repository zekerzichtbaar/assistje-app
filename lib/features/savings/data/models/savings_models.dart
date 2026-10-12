import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_models.freezed.dart';
part 'savings_models.g.dart';

/// Wie er meedoet aan een pot (`pot.scope`).
enum SavingsScope {
  /// Hele selectie (spelers).
  all,

  /// Spelers én staf.
  @JsonValue('all_staff')
  allStaff,

  /// Zelf gekozen deelnemers (`members`).
  custom,

  /// Wie zich aanmeldde voor `pot.event`.
  event,

  /// Een scope die deze appversie nog niet kent.
  unknown;

  /// De waarde die de API verwacht.
  String get apiValue => switch (this) {
    SavingsScope.allStaff => 'all_staff',
    _ => name,
  };
}

/// Soort deelnemer (`participants[].kind`).
enum SavingsParticipantKind { player, staff, unknown }

/// Waarom iemand zijn inleg terugkrijgt (`participants[].refund_reason`).
enum SavingsRefundReason { absent, left, cancelled, unknown }

/// Eén pot in het overzicht (`GET /savings` → `pots[]`).
@freezed
abstract class SavingsPotSummary with _$SavingsPotSummary {
  const factory SavingsPotSummary({
    required int id,
    @Default('') String name,
    @Default(0) int amountCents,
    int? goalCents,
    @Default(1) int months,
    @Default(0) int memberCount,
    @Default(0) int savedCents,
  }) = _SavingsPotSummary;

  const SavingsPotSummary._();

  factory SavingsPotSummary.fromJson(Map<String, dynamic> json) =>
      _$SavingsPotSummaryFromJson(json);

  /// Eenmalige inleg in plaats van per maand.
  bool get isOneOff => months == 1;

  /// Percentage van het doel (0–100), of `null` zonder doel.
  int? get goalPercent => savingsPercent(savedCents, goalCents);
}

/// `GET /teams/{team}/savings`.
@freezed
abstract class SavingsOverview with _$SavingsOverview {
  const factory SavingsOverview({
    @Default(<SavingsPotSummary>[]) List<SavingsPotSummary> pots,
    @Default(false) bool canManage,
  }) = _SavingsOverview;

  factory SavingsOverview.fromJson(Map<String, dynamic> json) =>
      _$SavingsOverviewFromJson(json);
}

/// De activiteit aan een pot, of een kiesbare activiteit in het formulier.
@freezed
abstract class SavingsEvent with _$SavingsEvent {
  const factory SavingsEvent({
    required int id,
    @Default('') String title,
    DateTime? startsAt,
    @Default(false) bool cancelled,
  }) = _SavingsEvent;

  factory SavingsEvent.fromJson(Map<String, dynamic> json) =>
      _$SavingsEventFromJson(json);
}

/// De kop van een pot (`pot` in het detail, en het antwoord op
/// aanmaken/wijzigen/afrekenen).
@freezed
abstract class SavingsPot with _$SavingsPot {
  const factory SavingsPot({
    required int id,
    @Default('') String name,
    @Default(0) int amountCents,
    int? goalCents,
    @Default(1) int months,
    DateTime? startsOn,
    @JsonKey(unknownEnumValue: SavingsScope.unknown)
    @Default(SavingsScope.all)
    SavingsScope scope,
    @Default(false) bool oneOff,
    SavingsEvent? event,
    int? actualCostCents,
    DateTime? settledOn,
  }) = _SavingsPot;

  const SavingsPot._();

  factory SavingsPot.fromJson(Map<String, dynamic> json) =>
      _$SavingsPotFromJson(json);

  /// Afgerekend (werkelijke kosten ingevuld).
  bool get isSettled => settledOn != null && actualCostCents != null;

  /// De gekoppelde activiteit is afgelast.
  bool get isCancelled => event?.cancelled ?? false;
}

/// Een rij in de matrix (`participants[]`).
@freezed
abstract class SavingsParticipant with _$SavingsParticipant {
  const factory SavingsParticipant({
    /// `p<player_id>` of `u<user_id>`.
    required String key,
    @Default('') String name,
    @JsonKey(unknownEnumValue: SavingsParticipantKind.unknown)
    @Default(SavingsParticipantKind.player)
    SavingsParticipantKind kind,
    int? shirtNumber,

    /// Betaalde, maar doet niet (meer) mee: krijgt zijn inleg terug.
    @Default(false) bool refund,
    @JsonKey(unknownEnumValue: SavingsRefundReason.unknown)
    SavingsRefundReason? refundReason,
    @Default(false) bool refunded,
  }) = _SavingsParticipant;

  const SavingsParticipant._();

  factory SavingsParticipant.fromJson(Map<String, dynamic> json) =>
      _$SavingsParticipantFromJson(json);

  bool get isStaff => kind == SavingsParticipantKind.staff;
}

/// Een afgetikte cel (`payments[]`), met het bedrag van toen.
@freezed
abstract class SavingsPayment with _$SavingsPayment {
  const factory SavingsPayment({
    required String key,
    required String ym,
    @Default(0) int cents,
  }) = _SavingsPayment;

  factory SavingsPayment.fromJson(Map<String, dynamic> json) =>
      _$SavingsPaymentFromJson(json);
}

/// `GET /teams/{team}/savings/{pot}`.
@freezed
abstract class SavingsPotDetail with _$SavingsPotDetail {
  const factory SavingsPotDetail({
    required SavingsPot pot,
    @Default(false) bool finesEnabled,
    @Default(<String>[]) List<String> periods,
    @Default(<SavingsParticipant>[]) List<SavingsParticipant> participants,
    @Default(<SavingsPayment>[]) List<SavingsPayment> payments,
    @Default(false) bool canManage,
  }) = _SavingsPotDetail;

  const SavingsPotDetail._();

  factory SavingsPotDetail.fromJson(Map<String, dynamic> json) =>
      _$SavingsPotDetailFromJson(json);

  /// Betaalde cellen: `key|ym` → centen.
  Map<String, int> get paid => {
    for (final payment in payments)
      cellKey(payment.key, payment.ym): payment.cents,
  };

  /// Wat er nu in de pot zit (som van de betaalde cellen).
  int get savedCents => payments.fold(0, (sum, p) => sum + p.cents);

  bool isPaid(String key, String ym) =>
      payments.any((p) => p.key == key && p.ym == ym);

  /// Wie meetelt (niet wie alleen nog iets terugkrijgt).
  List<SavingsParticipant> get counting => [
    for (final p in participants)
      if (!p.refund) p,
  ];

  /// Wie zijn inleg terugkrijgt.
  List<SavingsParticipant> get refunds => [
    for (final p in participants)
      if (p.refund) p,
  ];

  int get refundsOpen => refunds.where((p) => !p.refunded).length;

  /// De ene maand van een eenmalige inleg.
  String? get oneOffYm => periods.isEmpty ? null : periods.first;

  /// Eenmalig: hoeveel meetellende deelnemers betaalden.
  int get countingPaid {
    final ym = oneOffYm;
    if (ym == null) return 0;
    return counting.where((p) => isPaid(p.key, ym)).length;
  }

  /// Eenmalig: wat er nog open staat.
  int get openCents => (counting.length - countingPaid) * pot.amountCents;

  /// Aantal cellen in de matrix.
  int get cellsTotal => participants.length * periods.length;

  /// Percentage voor de ring: van het doel, of zonder doel van de vakjes.
  int? get ringPercent {
    final goal = savingsPercent(savedCents, pot.goalCents);
    if (goal != null) return goal;
    if (pot.oneOff) {
      final n = counting.length;
      return n == 0 ? null : (countingPaid * 100 / n).round();
    }
    return cellsTotal == 0
        ? null
        : (payments.length * 100 / cellsTotal).round();
  }

  /// Het doel, of zonder doel wat de pot oplevert als iedereen alles betaalt.
  int get targetCents =>
      pot.goalCents ??
      (pot.oneOff ? counting.length : participants.length * periods.length) *
          pot.amountCents;

  /// Wat deelnemer [key] in totaal betaalde.
  int rowCents(String key) =>
      payments.where((p) => p.key == key).fold(0, (sum, p) => sum + p.cents);

  /// Wat er in maand [ym] betaald is.
  int columnCents(String ym) =>
      payments.where((p) => p.ym == ym).fold(0, (sum, p) => sum + p.cents);

  /// Afrekening: betaald min werkelijke kosten (negatief = tekort).
  int? get settleDiffCents {
    final cost = pot.actualCostCents;
    return pot.isSettled && cost != null ? savedCents - cost : null;
  }

  /// Toont het detail een afrekenblok?
  bool get showsSettle =>
      (pot.oneOff || pot.event != null) && (canManage || pot.isSettled);

  /// Kan de penningmeester een herinnering sturen?
  bool get canRemind => canManage && counting.isNotEmpty && !pot.isCancelled;
}

/// `key|ym` — sleutel van een cel.
String cellKey(String key, String ym) => '$key|$ym';

/// [saved] als percentage (0–100, afgerond) van [goal]; `null` zonder doel.
int? savingsPercent(int saved, int? goal) {
  if (goal == null || goal <= 0) return null;
  final pct = (saved * 100 / goal).round();
  return pct > 100 ? 100 : (pct < 0 ? 0 : pct);
}

/// Een speler die je kunt kiezen (`people.players[]`).
@freezed
abstract class SavingsPlayerOption with _$SavingsPlayerOption {
  const factory SavingsPlayerOption({
    required String key,
    @Default('') String name,
    int? shirtNumber,
    @Default(false) bool isGuest,
  }) = _SavingsPlayerOption;

  factory SavingsPlayerOption.fromJson(Map<String, dynamic> json) =>
      _$SavingsPlayerOptionFromJson(json);
}

/// Een puur staflid dat je kunt kiezen (`people.staff[]`).
@freezed
abstract class SavingsStaffOption with _$SavingsStaffOption {
  const factory SavingsStaffOption({
    required String key,
    @Default('') String name,
  }) = _SavingsStaffOption;

  factory SavingsStaffOption.fromJson(Map<String, dynamic> json) =>
      _$SavingsStaffOptionFromJson(json);
}

@freezed
abstract class SavingsPeople with _$SavingsPeople {
  const factory SavingsPeople({
    @Default(<SavingsPlayerOption>[]) List<SavingsPlayerOption> players,
    @Default(<SavingsStaffOption>[]) List<SavingsStaffOption> staff,
  }) = _SavingsPeople;

  const SavingsPeople._();

  factory SavingsPeople.fromJson(Map<String, dynamic> json) =>
      _$SavingsPeopleFromJson(json);

  bool get hasGuests => players.any((p) => p.isGuest);
}

/// De huidige formulierwaarden van een pot (`GET …/edit` → `pot`), in euro's.
@freezed
abstract class SavingsFormValues with _$SavingsFormValues {
  const factory SavingsFormValues({
    required int id,
    @Default('') String name,
    @JsonKey(unknownEnumValue: SavingsScope.unknown)
    @Default(SavingsScope.all)
    SavingsScope scope,
    @Default(false) bool includeGuests,
    @Default(0) num amount,
    num? goal,
    @Default('') String startMonth,
    @Default(1) int months,
    @Default(<String>[]) List<String> members,
    int? eventId,
  }) = _SavingsFormValues;

  factory SavingsFormValues.fromJson(Map<String, dynamic> json) =>
      _$SavingsFormValuesFromJson(json);
}

/// `GET …/savings/create` en `GET …/savings/{pot}/edit`.
@freezed
abstract class SavingsFormOptions with _$SavingsFormOptions {
  const factory SavingsFormOptions({
    @Default(SavingsPeople()) SavingsPeople people,
    @Default(<SavingsEvent>[]) List<SavingsEvent> activities,
    int? presetEventId,

    /// Alleen bij bewerken.
    SavingsFormValues? pot,
  }) = _SavingsFormOptions;

  factory SavingsFormOptions.fromJson(Map<String, dynamic> json) =>
      _$SavingsFormOptionsFromJson(json);
}

/// Antwoord op `payments/toggle`: de nieuwe staat van de cel.
@freezed
abstract class SavingsToggleResult with _$SavingsToggleResult {
  const factory SavingsToggleResult({
    required String key,
    required String ym,
    @Default(false) bool paid,
    int? cents,
  }) = _SavingsToggleResult;

  factory SavingsToggleResult.fromJson(Map<String, dynamic> json) =>
      _$SavingsToggleResultFromJson(json);
}

/// Antwoord op `payments/refund`.
@freezed
abstract class SavingsRefundResult with _$SavingsRefundResult {
  const factory SavingsRefundResult({
    required String key,
    @Default(false) bool refunded,
  }) = _SavingsRefundResult;

  factory SavingsRefundResult.fromJson(Map<String, dynamic> json) =>
      _$SavingsRefundResultFromJson(json);
}
