import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/data/model/spending.dart';
import 'package:material_3_testing/data/source/local/category_local_source.dart';
import 'package:material_3_testing/data/source/local/key_local_source.dart';
import 'package:material_3_testing/data/source/local/preference_local_source.dart';
import 'package:material_3_testing/data/source/local/spending_local_source.dart';
import 'package:material_3_testing/domain/use_case/category/delete_category.dart';
import 'package:material_3_testing/domain/use_case/category/get_categories.dart';
import 'package:material_3_testing/domain/use_case/category/insert_category.dart';
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
  locator.registerSingletonAsync<SpendingLocalSourceBase>(() async {
    final KeyLocalSourceBase keystore = locator.get();

    String? key = await keystore.getKey();

    if (key == null) {
      await keystore.writeKey(null);
      key = await keystore.getKey();
    }

    final cipher = base64Url.decode(key!);

    final box = await Hive.openLazyBox<Spending>(
      'spending',
      encryptionCipher: HiveAesCipher(cipher),
    );

    return SpendingLocalSource(box);
  });
  locator.registerSingletonAsync<CategoryLocalSourceBase>(() async {
    final KeyLocalSourceBase keystore = locator.get();

    String? key = await keystore.getKey();

    if (key == null) {
      await keystore.writeKey(null);
      key = await keystore.getKey();
    }

    final cipher = base64Url.decode(key!);

    final box = await Hive.openBox<Category>(
      'category',
      encryptionCipher: HiveAesCipher(cipher),
    );

    return CategoryLocalSource(box);
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

  // Category use case
  locator.registerFactory(
    () => InsertCategory(locator.get()),
  );
  locator.registerFactory(
    () => DeleteCategory(locator.get()),
  );
  locator.registerFactory(
    () => GetCategories(locator.get()),
  );
}
