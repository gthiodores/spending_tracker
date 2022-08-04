import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/data/source/local/category_local_source.dart';

class InsertCategory {
  final CategoryLocalSourceBase _source;

  const InsertCategory(this._source);

  void execute(Category category) => _source.writeCategory(category);
}
