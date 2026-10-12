// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupDesignation _$SignupDesignationFromJson(Map<String, dynamic> json) =>
    _SignupDesignation(
      word: json['word'] as String? ?? 'team',
      question: json['question'] as String? ?? 'Welk team?',
      hint: json['hint'] as String? ?? '',
      example: json['example'] as String? ?? '',
    );

Map<String, dynamic> _$SignupDesignationToJson(_SignupDesignation instance) =>
    <String, dynamic>{
      'word': instance.word,
      'question': instance.question,
      'hint': instance.hint,
      'example': instance.example,
    };

_SignupFederationImport _$SignupFederationImportFromJson(
  Map<String, dynamic> json,
) => _SignupFederationImport(
  method: json['method'] as String?,
  name: json['name'] as String? ?? '',
  hint: json['hint'] as String? ?? '',
  example: json['example'] as String? ?? '',
);

Map<String, dynamic> _$SignupFederationImportToJson(
  _SignupFederationImport instance,
) => <String, dynamic>{
  'method': instance.method,
  'name': instance.name,
  'hint': instance.hint,
  'example': instance.example,
};

_SignupSport _$SignupSportFromJson(Map<String, dynamic> json) => _SignupSport(
  value: json['value'] as String,
  label: json['label'] as String? ?? '',
  designation: json['designation'] == null
      ? const SignupDesignation()
      : SignupDesignation.fromJson(json['designation'] as Map<String, dynamic>),
  federationImport: json['federation_import'] == null
      ? null
      : SignupFederationImport.fromJson(
          json['federation_import'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SignupSportToJson(_SignupSport instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'designation': instance.designation.toJson(),
      'federation_import': instance.federationImport?.toJson(),
    };

_SignupLimits _$SignupLimitsFromJson(Map<String, dynamic> json) =>
    _SignupLimits(
      trainingsMin: (json['trainings_min'] as num?)?.toInt() ?? 1,
      trainingsMax: (json['trainings_max'] as num?)?.toInt() ?? 7,
      logoMaxKb: (json['logo_max_kb'] as num?)?.toInt() ?? 2048,
      logoMimetypes:
          (json['logo_mimetypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['image/png', 'image/jpeg', 'image/svg+xml'],
      clubSearchMinChars: (json['club_search_min_chars'] as num?)?.toInt() ?? 2,
    );

Map<String, dynamic> _$SignupLimitsToJson(_SignupLimits instance) =>
    <String, dynamic>{
      'trainings_min': instance.trainingsMin,
      'trainings_max': instance.trainingsMax,
      'logo_max_kb': instance.logoMaxKb,
      'logo_mimetypes': instance.logoMimetypes,
      'club_search_min_chars': instance.clubSearchMinChars,
    };

_SignupOptions _$SignupOptionsFromJson(Map<String, dynamic> json) =>
    _SignupOptions(
      sports:
          (json['sports'] as List<dynamic>?)
              ?.map((e) => SignupSport.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SignupSport>[],
      sport: json['sport'] as String?,
      limits: json['limits'] == null
          ? const SignupLimits()
          : SignupLimits.fromJson(json['limits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupOptionsToJson(_SignupOptions instance) =>
    <String, dynamic>{
      'sports': instance.sports.map((e) => e.toJson()).toList(),
      'sport': instance.sport,
      'limits': instance.limits.toJson(),
    };

_SignupClub _$SignupClubFromJson(Map<String, dynamic> json) => _SignupClub(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  place: json['place'] as String?,
  logoUrl: json['logo_url'] as String?,
);

Map<String, dynamic> _$SignupClubToJson(_SignupClub instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'place': instance.place,
      'logo_url': instance.logoUrl,
    };

_SignupTeam _$SignupTeamFromJson(Map<String, dynamic> json) => _SignupTeam(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  slug: json['slug'] as String? ?? '',
  sport: json['sport'] as String?,
  url: json['url'] as String? ?? '',
);

Map<String, dynamic> _$SignupTeamToJson(_SignupTeam instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'sport': instance.sport,
      'url': instance.url,
    };

_SignupSent _$SignupSentFromJson(Map<String, dynamic> json) => _SignupSent(
  email: json['email'] as String? ?? '',
  already: json['already'] as bool? ?? false,
  team: SignupTeam.fromJson(json['team'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SignupSentToJson(_SignupSent instance) =>
    <String, dynamic>{
      'email': instance.email,
      'already': instance.already,
      'team': instance.team.toJson(),
    };

_SignupRequested _$SignupRequestedFromJson(Map<String, dynamic> json) =>
    _SignupRequested(
      sport: json['sport'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$SignupRequestedToJson(_SignupRequested instance) =>
    <String, dynamic>{'sport': instance.sport, 'email': instance.email};

_SignupTraining _$SignupTrainingFromJson(Map<String, dynamic> json) =>
    _SignupTraining(
      weekday: (json['weekday'] as num).toInt(),
      startsAt: json['starts_at'] as String? ?? '19:30',
      endsAt: json['ends_at'] as String? ?? '21:00',
      venue: json['venue'] as String? ?? '',
    );

Map<String, dynamic> _$SignupTrainingToJson(_SignupTraining instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'venue': instance.venue,
    };
