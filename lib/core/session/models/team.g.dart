// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  sport: json['sport'] as String,
  logoUrl: json['logo_url'] as String?,
  logoFills: json['logo_fills'] as bool? ?? false,
  primaryColor: json['primary_color'] as String?,
  url: json['url'] as String?,
  isDemo: json['is_demo'] as bool? ?? false,
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'sport': instance.sport,
  'logo_url': instance.logoUrl,
  'logo_fills': instance.logoFills,
  'primary_color': instance.primaryColor,
  'url': instance.url,
  'is_demo': instance.isDemo,
};
