import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/data/source/local/category_local_source.dart';

class GetCategories {
  final CategoryLocalSourceBase _source;

  const GetCategories(this._source);

  Stream<List<Category>> execute() => _source.watchCategories();
}
