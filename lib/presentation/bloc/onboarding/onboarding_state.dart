part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final bool onboardingCompleted;

  const OnboardingState({
    required this.currentPage,
    this.onboardingCompleted = false,
  });

  @override
  List<Object?> get props => [currentPage, onboardingCompleted];
}
