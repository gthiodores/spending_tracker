import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';

abstract class PreferenceLocalSourceBase {
  Stream<bool> watchDarkModePreference();

  void writeDarkModePreference(bool darkMode);

  void writeOnboardingState();

  void writePreferredCurrency(CurrencyEnum preferred);

  bool getDarkModePreference();

  bool getOnboardingState();

  CurrencyEnum getPreferredCurrency();
}

class PreferenceLocalSource extends PreferenceLocalSourceBase {
  final String _darkMode = 'dark_mode';
  final String _onboarding = 'onboarding';
  final String _currency = 'currency';

  final Box box;

  PreferenceLocalSource(this.box);

  @override
  Stream<bool> watchDarkModePreference() =>
      box.watch(key: _darkMode).map((event) => event.value ?? false);

  @override
  void writeDarkModePreference(bool darkMode) => box.put(_darkMode, darkMode);

  @override
  void writeOnboardingState() => box.put(_onboarding, true);

  @override
  bool getDarkModePreference() => box.get(_darkMode) ?? false;

  @override
  bool getOnboardingState() => box.get(_onboarding) ?? false;

  @override
  CurrencyEnum getPreferredCurrency() => box.get(_currency) ?? CurrencyEnum.idr;

  @override
  void writePreferredCurrency(CurrencyEnum preferred) =>
      box.put(_currency, preferred);
}
