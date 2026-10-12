// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingTeam _$OnboardingTeamFromJson(Map<String, dynamic> json) =>
    _OnboardingTeam(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      onboardedAt: json['onboarded_at'] as String?,
      needsOnboarding: json['needs_onboarding'] as bool? ?? true,
    );

Map<String, dynamic> _$OnboardingTeamToJson(_OnboardingTeam instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'onboarded_at': instance.onboardedAt,
      'needs_onboarding': instance.needsOnboarding,
    };

_OnboardingStep _$OnboardingStepFromJson(Map<String, dynamic> json) =>
    _OnboardingStep(
      key: json['key'] as String,
      title: json['title'] as String? ?? '',
      text: json['text'] as String? ?? '',
      href: json['href'] as String? ?? '/',
      url: json['url'] as String?,
      cta: json['cta'] as String? ?? '',
      done: json['done'] as bool? ?? false,
    );

Map<String, dynamic> _$OnboardingStepToJson(_OnboardingStep instance) =>
    <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'text': instance.text,
      'href': instance.href,
      'url': instance.url,
      'cta': instance.cta,
      'done': instance.done,
    };

_OnboardingNextMatch _$OnboardingNextMatchFromJson(Map<String, dynamic> json) =>
    _OnboardingNextMatch(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      startsAt: json['starts_at'] as String?,
      responded: (json['responded'] as num?)?.toInt() ?? 0,
      roster: (json['roster'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OnboardingNextMatchToJson(
  _OnboardingNextMatch instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'starts_at': instance.startsAt,
  'responded': instance.responded,
  'roster': instance.roster,
};

_Onboarding _$OnboardingFromJson(Map<String, dynamic> json) => _Onboarding(
  team: OnboardingTeam.fromJson(json['team'] as Map<String, dynamic>),
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => OnboardingStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OnboardingStep>[],
  scheduleRequest: json['schedule_request'] == null
      ? ScheduleRequestState.none
      : ScheduleRequestState.parse(json['schedule_request']),
  nextMatch: json['next_match'] == null
      ? null
      : OnboardingNextMatch.fromJson(
          json['next_match'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OnboardingToJson(_Onboarding instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'next_match': instance.nextMatch?.toJson(),
    };
