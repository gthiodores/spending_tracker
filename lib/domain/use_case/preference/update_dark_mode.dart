import 'package:material_3_testing/data/source/local/preference_local_source.dart';

class UpdateDarkMode {
  final PreferenceLocalSourceBase _preference;

  const UpdateDarkMode(this._preference);

  void execute(bool darkMode) => _preference.writeDarkModePreference(darkMode);
}
