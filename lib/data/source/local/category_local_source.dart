import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/category.dart';

abstract class CategoryLocalSourceBase {
  List<Category> getCategories();

  void writeCategory(Category category);

  void updateCategory(Category category);

  void deleteCategory(Category category);
}

class CategoryLocalSource extends CategoryLocalSourceBase {
  final Box<Category> _box;

  CategoryLocalSource(this._box);

  @override
  void deleteCategory(Category category) => category.delete();

  @override
  List<Category> getCategories() => _box.values.toList();

  @override
  void updateCategory(Category category) => category.save();

  @override
  void writeCategory(Category category) => _box.add(category);
}
