import 'package:material_3_testing/data/source/local/preference_local_source.dart';

class GetDarkModeState {
  final PreferenceLocalSourceBase _preference;

  const GetDarkModeState(this._preference);

  bool execute() => _preference.getDarkModePreference();
}
