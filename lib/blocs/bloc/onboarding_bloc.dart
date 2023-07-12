import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
       if (event is StartTimerEvent) {
        emit(OnboardingTimerInProgress());
        _startTimer();
      } else if (event is TimerFinishedEvent) {
        emit(OnboardingTimerFinished());
      }
    });
  }

  void _startTimer() {
    // Simulating a 3-second timer
    Timer(Duration(seconds: 3), () {
      add(TimerFinishedEvent());
    
      // TODO: implement event handler
    });
  }
}
