import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/use_case/preference/get_dark_mode_state.dart';
import 'package:material_3_testing/domain/use_case/preference/get_preferred_currency.dart';
import 'package:material_3_testing/domain/use_case/preference/update_dark_mode.dart';
import 'package:material_3_testing/domain/use_case/preference/update_preferred_currency.dart';
import 'package:material_3_testing/domain/use_case/preference/watch_dark_mode.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';

part 'preference_event.dart';

part 'preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  final WatchDarkMode _watchDarkMode;
  final UpdateDarkMode _updateDarkMode;
  final GetDarkModeState _getDarkMode;
  final UpdatePreferredCurrency _updatePreferredCurrency;
  final GetPreferredCurrency _getPreferredCurrency;

  PreferenceBloc(
    this._watchDarkMode,
    this._updateDarkMode,
    this._getDarkMode,
    this._updatePreferredCurrency,
    this._getPreferredCurrency,
  ) : super(const PreferenceState(false, CurrencyEnum.idr)) {
    on<PreferenceInit>((event, emit) {
      emit(PreferenceState(
        _getDarkMode.execute(),
        _getPreferredCurrency.execute(),
      ));

      return emit.forEach(
        _watchDarkMode.execute(),
        onData: (bool darkMode) => PreferenceState(
          darkMode,
          state.preferredCurrency,
        ),
      );
    });

    on<PreferenceDarkModeChanged>((event, emit) {
      _updateDarkMode.execute(event.darkMode);
    });

    on<PreferencePreferredCurrencyChanged>((event, emit) {
      _updatePreferredCurrency.execute(event.preferred);
      emit(PreferenceState(state.darkMode, event.preferred));
    });
  }
}
