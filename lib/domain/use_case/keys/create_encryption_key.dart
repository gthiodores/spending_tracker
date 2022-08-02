import 'package:material_3_testing/data/source/local/key_local_source.dart';

class CreateEncryptionKey {
  final KeyLocalSourceBase _keySource;

  const CreateEncryptionKey(this._keySource);

  Future<void> execute(String? key) => _keySource.writeKey(key);
}
