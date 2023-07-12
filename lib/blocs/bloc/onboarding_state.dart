part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingTimerInProgress extends OnboardingState {}

class OnboardingTimerFinished extends OnboardingState {}



