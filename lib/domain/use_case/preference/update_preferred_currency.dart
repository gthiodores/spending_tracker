import 'package:material_3_testing/data/source/local/preference_local_source.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';

class UpdatePreferredCurrency {
  final PreferenceLocalSourceBase _preference;

  const UpdatePreferredCurrency(this._preference);

  void execute(CurrencyEnum preferred) =>
      _preference.writePreferredCurrency(preferred);
}
