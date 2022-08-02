import 'package:material_3_testing/data/source/local/preference_local_source.dart';

class UpdateOnboardingState {
  final PreferenceLocalSourceBase _preference;

  const UpdateOnboardingState(this._preference);

  void execute() => _preference.writeOnboardingState();
}
