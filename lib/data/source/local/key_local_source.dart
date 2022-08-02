import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

abstract class KeyLocalSourceBase {
  /// Get the cipher key written into the source
  Future<String?> getKey();

  /// Write a cipher key into the source,
  /// if no cipher is provided then defaults to a generated key
  Future<void> writeKey(String? key);
}

class KeyLocalSource extends KeyLocalSourceBase {
  final FlutterSecureStorage _secureStorage;

  KeyLocalSource(this._secureStorage);

  @override
  Future<String?> getKey() => _secureStorage.read(key: 'key');

  @override
  Future<void> writeKey(String? key) => _secureStorage.write(
        key: 'key',
        value: key ?? base64UrlEncode(Hive.generateSecureKey()),
      );
}
