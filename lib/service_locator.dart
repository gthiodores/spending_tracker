import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:material_3_testing/data/source/local/key_local_source.dart';
import 'package:material_3_testing/data/source/local/preference_local_source.dart';
import 'package:material_3_testing/domain/use_case/keys/create_encryption_key.dart';
import 'package:material_3_testing/domain/use_case/keys/get_encryption_key.dart';
import 'package:material_3_testing/domain/use_case/preference/get_dark_mode_state.dart';
import 'package:material_3_testing/domain/use_case/preference/get_onboarding_state.dart';
import 'package:material_3_testing/domain/use_case/preference/get_preferred_currency.dart';
import 'package:material_3_testing/domain/use_case/preference/update_dark_mode.dart';
import 'package:material_3_testing/domain/use_case/preference/update_onboarding_state.dart';
import 'package:material_3_testing/domain/use_case/preference/update_preferred_currency.dart';
import 'package:material_3_testing/domain/use_case/preference/watch_dark_mode.dart';

final locator = GetIt.instance;

void initLocatorAppModule() {
  // Third party dependencies
  locator.registerSingleton(const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  ));

  // Local Data Sources
  locator.registerFactory<KeyLocalSourceBase>(
    () => KeyLocalSource(locator.get()),
  );
  locator.registerSingletonAsync<PreferenceLocalSourceBase>(() async {
    final box = await Hive.openBox('preference');
    return PreferenceLocalSource(box);
  });

  // Encrypt use case
  locator.registerFactory(
    () => CreateEncryptionKey(locator.get()),
  );
  locator.registerFactory(
    () => GetEncryptionKey(locator.get()),
  );

  // Preference use case
  locator.registerFactory(
    () => WatchDarkMode(locator.get()),
  );
  locator.registerFactory(
    () => UpdateDarkMode(locator.get()),
  );
  locator.registerFactory(
    () => GetDarkModeState(locator.get()),
  );
  locator.registerFactory(
    () => GetOnboardingState(locator.get()),
  );
  locator.registerFactory(
    () => GetPreferredCurrency(locator.get()),
  );
  locator.registerFactory(
    () => UpdateOnboardingState(locator.get()),
  );
  locator.registerFactory(
    () => UpdatePreferredCurrency(locator.get()),
  );
}