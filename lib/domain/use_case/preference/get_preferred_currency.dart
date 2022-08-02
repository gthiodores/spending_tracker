import 'package:material_3_testing/data/source/local/preference_local_source.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';

class GetPreferredCurrency {
  final PreferenceLocalSourceBase _preference;

  const GetPreferredCurrency(this._preference);

  CurrencyEnum execute() => _preference.getPreferredCurrency();
}
