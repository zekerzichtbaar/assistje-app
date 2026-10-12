// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreements_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Agreement _$AgreementFromJson(Map<String, dynamic> json) => _Agreement(
  id: (json['id'] as num).toInt(),
  category: json['category'] as String? ?? 'other',
  categoryLabel: json['category_label'] as String?,
  title: json['title'] as String? ?? '',
  body: json['body'] as String?,
  sortOrder: (json['sort_order'] as num?)?.toInt(),
);

Map<String, dynamic> _$AgreementToJson(_Agreement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'category_label': instance.categoryLabel,
      'title': instance.title,
      'body': instance.body,
      'sort_order': instance.sortOrder,
    };

_AgreementGroup _$AgreementGroupFromJson(Map<String, dynamic> json) =>
    _AgreementGroup(
      key: json['key'] as String,
      label: json['label'] as String? ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => Agreement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Agreement>[],
    );

Map<String, dynamic> _$AgreementGroupToJson(_AgreementGroup instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

_AgreementCategory _$AgreementCategoryFromJson(Map<String, dynamic> json) =>
    _AgreementCategory(
      key: json['key'] as String,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$AgreementCategoryToJson(_AgreementCategory instance) =>
    <String, dynamic>{'key': instance.key, 'label': instance.label};

_AgreementsOverview _$AgreementsOverviewFromJson(Map<String, dynamic> json) =>
    _AgreementsOverview(
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map((e) => AgreementGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AgreementGroup>[],
      intro: json['intro'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map(
                (e) => AgreementCategory.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <AgreementCategory>[],
      canManage: json['can_manage'] as bool? ?? false,
    );

Map<String, dynamic> _$AgreementsOverviewToJson(_AgreementsOverview instance) =>
    <String, dynamic>{
      'groups': instance.groups.map((e) => e.toJson()).toList(),
      'intro': instance.intro,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'can_manage': instance.canManage,
    };
