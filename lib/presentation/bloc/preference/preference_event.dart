part of 'preference_bloc.dart';

abstract class PreferenceEvent extends Equatable {
  const PreferenceEvent();
}

class PreferenceInit extends PreferenceEvent {
  @override
  List<Object?> get props => [];
}

class PreferenceDarkModeChanged extends PreferenceEvent {
  final bool darkMode;

  const PreferenceDarkModeChanged(this.darkMode);

  @override
  List<Object?> get props => [darkMode];
}

class PreferencePreferredCurrencyChanged extends PreferenceEvent {
  final CurrencyEnum preferred;

  const PreferencePreferredCurrencyChanged(this.preferred);

  @override
  List<Object?> get props => [preferred];
}
