import 'package:material_3_testing/data/source/local/category_local_source.dart';

class UpdateCategory {
  final CategoryLocalSourceBase _source;

  const UpdateCategory(this._source);

  void execute(dynamic key, String name) => _source.updateCategory(key, name);
}
