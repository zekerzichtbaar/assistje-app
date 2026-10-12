import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_models.freezed.dart';
part 'onboarding_models.g.dart';

/// Het team in de checklist (`data.team`).
@freezed
abstract class OnboardingTeam with _$OnboardingTeam {
  const factory OnboardingTeam({
    required int id,
    @Default('') String name,
    String? onboardedAt,
    @Default(true) bool needsOnboarding,
  }) = _OnboardingTeam;

  factory OnboardingTeam.fromJson(Map<String, dynamic> json) =>
      _$OnboardingTeamFromJson(json);
}

/// Eén stap (`steps[]`): altijd `team`, `schedule`, `attendance`. [href] is
/// het webpad; de app mapt het met `DeepLinkMapper` op een eigen scherm.
@freezed
abstract class OnboardingStep with _$OnboardingStep {
  const factory OnboardingStep({
    required String key,
    @Default('') String title,
    @Default('') String text,
    @Default('/') String href,
    String? url,
    @Default('') String cta,
    @Default(false) bool done,
  }) = _OnboardingStep;

  factory OnboardingStep.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStepFromJson(json);
}

/// De eerstvolgende wedstrijd met hoeveel spelers al reageerden.
@freezed
abstract class OnboardingNextMatch with _$OnboardingNextMatch {
  const factory OnboardingNextMatch({
    required int id,
    @Default('') String title,
    String? startsAt,
    @Default(0) int responded,
    @Default(0) int roster,
  }) = _OnboardingNextMatch;

  const OnboardingNextMatch._();

  factory OnboardingNextMatch.fromJson(Map<String, dynamic> json) =>
      _$OnboardingNextMatchFromJson(json);

  /// Deel van de selectie dat reageerde, 0–1.
  double get progress =>
      roster <= 0 ? 0 : (responded / roster).clamp(0, 1).toDouble();
}

/// `schedule_request`: kan de trainer ons het programma laten invoeren?
enum ScheduleRequestState {
  /// Geen aanbod (bijv. bij een agendakoppeling).
  none,

  /// Je kunt het aanvragen.
  available,

  /// Aangevraagd; de `schedule`-stap telt als gedaan.
  pending;

  static ScheduleRequestState parse(Object? raw) => switch (raw) {
    'available' => available,
    'pending' => pending,
    _ => none,
  };
}

/// Hoe een stap in de lijst staat (zoals `StepState` in de PWA).
enum OnboardingStepState { done, current, upcoming }

/// De hele checklist (`GET /teams/{team}/onboarding`).
@freezed
abstract class Onboarding with _$Onboarding {
  const factory Onboarding({
    required OnboardingTeam team,
    @Default(<OnboardingStep>[]) List<OnboardingStep> steps,
    @JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false)
    @Default(ScheduleRequestState.none)
    ScheduleRequestState scheduleRequest,
    OnboardingNextMatch? nextMatch,
  }) = _Onboarding;

  const Onboarding._();

  factory Onboarding.fromJson(Map<String, dynamic> json) =>
      _$OnboardingFromJson(json);

  /// Index van de eerste open stap, of -1 als alles gedaan is.
  int get currentIndex => steps.indexWhere((step) => !step.done);

  bool get allDone => currentIndex == -1;

  int get completed => steps.where((step) => step.done).length;

  int get left => steps.length - completed;

  OnboardingStepState stateOf(int index) {
    if (steps[index].done) return OnboardingStepState.done;
    return index == currentIndex
        ? OnboardingStepState.current
        : OnboardingStepState.upcoming;
  }
}
