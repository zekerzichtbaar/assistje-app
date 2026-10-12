import 'package:freezed_annotation/freezed_annotation.dart';

part 'fines_models.freezed.dart';
part 'fines_models.g.dart';

/// Status van een boete (`fines[].status`).
enum FineStatus {
  open,
  paid,
  waived,

  /// Een status die deze appversie nog niet kent.
  unknown,
}

/// Soort regel in `pot.lines` (`kind`).
enum PotLineKind {
  /// Met de hand geboekt (heeft een `id`, is te bewerken).
  entry,

  /// Betaalde boetes van één periode (berekend).
  fines,

  /// Afrekening van een spaarpot (berekend).
  settlement,

  /// Een soort die deze appversie nog niet kent.
  unknown,
}

/// Een boeteperiode (`period` en `periods[]`).
@freezed
abstract class FinePeriod with _$FinePeriod {
  const factory FinePeriod({
    required int id,
    @Default('') String name,
    DateTime? startsOn,
    DateTime? endsOn,
    DateTime? closedAt,
  }) = _FinePeriod;

  const FinePeriod._();

  factory FinePeriod.fromJson(Map<String, dynamic> json) =>
      _$FinePeriodFromJson(json);

  bool get isClosed => closedAt != null;
}

/// Eén persoon in het overzicht (`rows[]`).
@freezed
abstract class FineRow with _$FineRow {
  const factory FineRow({
    /// `p<player_id>` of `u<user_id>`.
    required String key,
    int? playerId,
    int? userId,
    @Default('') String name,
    int? shirtNumber,
    String? avatarUrl,
    @Default(false) bool isStaff,

    /// Telt mee voor nieuwe boetes.
    @Default(true) bool counting,
    @Default(0) int totalCents,
    @Default(0) int openCents,
    @Default(0) int count,
  }) = _FineRow;

  const FineRow._();

  factory FineRow.fromJson(Map<String, dynamic> json) =>
      _$FineRowFromJson(json);

  /// Puur staf (boetes hangen aan het account) in plaats van een speler.
  bool get isStaffOnly => playerId == null && userId != null;
}

/// Een kiesbare boetesoort (`fine_types[]`).
@freezed
abstract class FineType with _$FineType {
  const factory FineType({
    required int id,
    @Default('') String label,
    @Default(0) int defaultCents,

    /// `null` voor handmatige soorten.
    String? trigger,
    String? triggerLabel,

    /// Uitgezette automatische soort: niet tonen bij uitdelen.
    @Default(false) bool archived,
  }) = _FineType;

  factory FineType.fromJson(Map<String, dynamic> json) =>
      _$FineTypeFromJson(json);
}

/// Totalen in centen.
@freezed
abstract class FineTotals with _$FineTotals {
  const factory FineTotals({
    @Default(0) int openCents,
    @Default(0) int allCents,
  }) = _FineTotals;

  factory FineTotals.fromJson(Map<String, dynamic> json) =>
      _$FineTotalsFromJson(json);
}

/// Eén regel van de pot (`pot.lines[]`, ook het antwoord op `fine-pot`).
@freezed
abstract class PotLine with _$PotLine {
  const factory PotLine({
    required String key,
    @JsonKey(unknownEnumValue: PotLineKind.unknown)
    @Default(PotLineKind.unknown)
    PotLineKind kind,

    /// Alleen bij [PotLineKind.entry].
    int? id,
    @Default(0) int amountCents,
    @Default('') String description,
    DateTime? occurredOn,
    String? createdBy,
  }) = _PotLine;

  const PotLine._();

  factory PotLine.fromJson(Map<String, dynamic> json) =>
      _$PotLineFromJson(json);

  /// Met de hand geboekt en dus te bewerken/verwijderen.
  bool get isEditable => kind == PotLineKind.entry && id != null;
}

/// De pot over alle periodes heen.
@freezed
abstract class FinePot with _$FinePot {
  const factory FinePot({
    @Default(0) int balanceCents,
    @Default(0) int openCents,
    @Default(<PotLine>[]) List<PotLine> lines,
  }) = _FinePot;

  factory FinePot.fromJson(Map<String, dynamic> json) =>
      _$FinePotFromJson(json);
}

/// `GET teams/{team}/fines`.
@freezed
abstract class FinesOverview with _$FinesOverview {
  const factory FinesOverview({
    required FinePeriod period,
    @Default(<FinePeriod>[]) List<FinePeriod> periods,
    @Default(<FineRow>[]) List<FineRow> rows,
    @Default(<FineType>[]) List<FineType> fineTypes,
    @Default(false) bool guestsInFines,
    @Default(false) bool staffInFines,
    @Default(FineTotals()) FineTotals totals,
    @Default(FinePot()) FinePot pot,
    @Default(false) bool canManage,
  }) = _FinesOverview;

  const FinesOverview._();

  factory FinesOverview.fromJson(Map<String, dynamic> json) =>
      _$FinesOverviewFromJson(json);

  /// De soorten die je kunt uitdelen.
  List<FineType> get activeFineTypes => [
    for (final type in fineTypes)
      if (!type.archived) type,
  ];

  /// Wie een nieuwe boete kan krijgen.
  List<FineRow> get countingRows => [
    for (final row in rows)
      if (row.counting && (!row.isStaffOnly || staffInFines)) row,
  ];
}

/// Het event waar een boete bij hoort.
@freezed
abstract class FineEvent with _$FineEvent {
  const factory FineEvent({
    required int id,
    @Default('') String title,
    DateTime? startsAt,
  }) = _FineEvent;

  factory FineEvent.fromJson(Map<String, dynamic> json) =>
      _$FineEventFromJson(json);
}

/// Eén boete.
@freezed
abstract class Fine with _$Fine {
  const factory Fine({
    required int id,

    /// Id van de boetesoort (`null` = geen soort, "Overig").
    int? type,
    @Default('') String typeLabel,
    @Default(0) int amountCents,
    String? description,
    @JsonKey(unknownEnumValue: FineStatus.unknown)
    @Default(FineStatus.open)
    FineStatus status,
    DateTime? paidAt,
    FineEvent? event,
    DateTime? createdAt,
    String? createdBy,
  }) = _Fine;

  factory Fine.fromJson(Map<String, dynamic> json) => _$FineFromJson(json);
}

/// De persoon bovenaan een detail (`player`; bij staf is `id` het user-id).
@freezed
abstract class FinePerson with _$FinePerson {
  const factory FinePerson({
    required int id,
    @Default('') String name,
    int? shirtNumber,
    String? avatarUrl,
  }) = _FinePerson;

  factory FinePerson.fromJson(Map<String, dynamic> json) =>
      _$FinePersonFromJson(json);
}

/// `GET teams/{team}/fines/players/{player}` en `…/staff/{user}`.
@freezed
abstract class PersonFines with _$PersonFines {
  const factory PersonFines({
    required FinePeriod period,
    @JsonKey(name: 'player') required FinePerson person,
    @Default(<Fine>[]) List<Fine> fines,
    @Default(FineTotals()) FineTotals totals,
    @Default(<FineType>[]) List<FineType> fineTypes,
    @Default(false) bool canManage,
  }) = _PersonFines;

  factory PersonFines.fromJson(Map<String, dynamic> json) =>
      _$PersonFinesFromJson(json);
}
