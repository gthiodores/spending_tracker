import 'package:material_3_testing/data/source/local/category_local_source.dart';

class DeleteCategory {
  final CategoryLocalSourceBase _source;

  const DeleteCategory(this._source);

  void execute(dynamic key) => _source.deleteCategory(key);
}
