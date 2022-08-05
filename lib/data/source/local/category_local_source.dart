import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:rxdart/rxdart.dart';

abstract class CategoryLocalSourceBase {
  Stream<List<Category>> getCategories();

  void writeCategory(Category category);

  void updateCategory(dynamic key, String name);

  void deleteCategory(dynamic key);
}

class CategoryLocalSource extends CategoryLocalSourceBase {
  final Box<Category> _box;

  CategoryLocalSource(this._box);

  @override
  void deleteCategory(dynamic key) {
    final category = _box.get(key);
    category?.delete();
  }

  @override
  Stream<List<Category>> getCategories() => _box
      .watch()
      .map((value) => _box.values.toList())
      .startWith(_box.values.toList());

  @override
  void updateCategory(dynamic key, String name) {
    final category = _box.get(key);
    category?.name = name;
    category?.save();
  }

  @override
  void writeCategory(Category category) => _box.add(category);
}
