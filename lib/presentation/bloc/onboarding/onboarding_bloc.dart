import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/use_case/preference/get_onboarding_state.dart';
import 'package:material_3_testing/domain/use_case/preference/update_onboarding_state.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final UpdateOnboardingState _updateOnboarding;
  final GetOnboardingState _getOnboardingState;

  OnboardingBloc(
    this._updateOnboarding,
    this._getOnboardingState,
  ) : super(const OnboardingState(currentPage: 0)) {
    on<OnboardingInit>((event, emit) {
      emit(OnboardingState(
        currentPage: 0,
        onboardingCompleted: _getOnboardingState.execute(),
      ));
    });

    on<OnboardingPageChange>((event, emit) {
      emit(OnboardingState(currentPage: event.index));
    });

    on<OnboardingDoneEvent>((event, emit) async {
      _updateOnboarding.execute();
      emit(OnboardingState(
        currentPage: state.currentPage,
        onboardingCompleted: true,
      ));
    });
  }
}
