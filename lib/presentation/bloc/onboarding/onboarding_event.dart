part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class OnboardingPageChange extends OnboardingEvent {
  final int index;

  const OnboardingPageChange(this.index);

  @override
  List<Object?> get props => [index];
}

class OnboardingDoneEvent extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}

class OnboardingInit extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}
