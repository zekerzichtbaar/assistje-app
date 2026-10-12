import 'package:freezed_annotation/freezed_annotation.dart';

part 'agreements_models.freezed.dart';
part 'agreements_models.g.dart';

/// Eén teamafspraak (`groups[].items[]`, en de `POST`/`PATCH`-respons).
@freezed
abstract class Agreement with _$Agreement {
  const factory Agreement({
    required int id,
    @Default('other') String category,

    /// Alleen in de schrijfrespons.
    String? categoryLabel,
    @Default('') String title,
    String? body,
    int? sortOrder,
  }) = _Agreement;

  factory Agreement.fromJson(Map<String, dynamic> json) =>
      _$AgreementFromJson(json);
}

/// Een categorie met afspraken (`groups[]`), in de vaste volgorde.
@freezed
abstract class AgreementGroup with _$AgreementGroup {
  const factory AgreementGroup({
    required String key,
    @Default('') String label,
    @Default(<Agreement>[]) List<Agreement> items,
  }) = _AgreementGroup;

  factory AgreementGroup.fromJson(Map<String, dynamic> json) =>
      _$AgreementGroupFromJson(json);
}

/// Een kiesbare categorie (`categories[]`).
@freezed
abstract class AgreementCategory with _$AgreementCategory {
  const factory AgreementCategory({
    required String key,
    @Default('') String label,
  }) = _AgreementCategory;

  factory AgreementCategory.fromJson(Map<String, dynamic> json) =>
      _$AgreementCategoryFromJson(json);
}

/// `GET teams/{team}/agreements`.
@freezed
abstract class AgreementsOverview with _$AgreementsOverview {
  const factory AgreementsOverview({
    @Default(<AgreementGroup>[]) List<AgreementGroup> groups,
    String? intro,
    @Default(<AgreementCategory>[]) List<AgreementCategory> categories,
    @Default(false) bool canManage,
  }) = _AgreementsOverview;

  const AgreementsOverview._();

  factory AgreementsOverview.fromJson(Map<String, dynamic> json) =>
      _$AgreementsOverviewFromJson(json);

  /// Nog geen enkele afspraak.
  bool get isEmpty => groups.every((group) => group.items.isEmpty);

  /// De introtekst, of `null` als die leeg is.
  String? get introText {
    final text = intro?.trim();
    return text == null || text.isEmpty ? null : intro;
  }
}
