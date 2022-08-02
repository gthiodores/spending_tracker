import 'package:material_3_testing/data/source/local/key_local_source.dart';

class GetEncryptionKey {
  final KeyLocalSourceBase _keySource;

  const GetEncryptionKey(this._keySource);

  Future<String?> execute() => _keySource.getKey();
}
