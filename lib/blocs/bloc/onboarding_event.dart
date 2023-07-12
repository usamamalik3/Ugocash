part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}
class StartTimerEvent extends OnboardingEvent {}

class TimerFinishedEvent extends OnboardingEvent {}