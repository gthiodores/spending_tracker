import 'package:material_3_testing/data/source/local/preference_local_source.dart';

class GetOnboardingState {
  final PreferenceLocalSourceBase _preference;

  const GetOnboardingState(this._preference);

  bool execute() => _preference.getOnboardingState();
}
