import 'package:material_3_testing/data/source/local/preference_local_source.dart';

class WatchDarkMode {
  final PreferenceLocalSourceBase _preference;

  const WatchDarkMode(this._preference);

  Stream<bool> execute() => _preference.watchDarkModePreference();
}
