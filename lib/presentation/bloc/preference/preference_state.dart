part of 'preference_bloc.dart';

class PreferenceState extends Equatable {
  final bool darkMode;
  final CurrencyEnum preferredCurrency;

  const PreferenceState(this.darkMode, this.preferredCurrency);

  @override
  List<Object?> get props => [darkMode, preferredCurrency];
}
