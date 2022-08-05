import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:rxdart/rxdart.dart';

abstract class CategoryLocalSourceBase {
  Stream<List<Category>> watchCategories();

  List<Category> getCategories();

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
  Stream<List<Category>> watchCategories() =>
      _box.watch().map((value) => getCategories()).startWith(getCategories());

  @override
  List<Category> getCategories() => _box.values.toList();

  @override
  void updateCategory(dynamic key, String name) {
    final time = (DateTime.now().toUtc().millisecondsSinceEpoch) ~/ 1000;
    final hexTime = time.toRadixString(16);

    print("updateTime: $hexTime");

    final timeInSeconds = int.parse(hexTime, radix: 16);
    final parsed = DateTime.fromMillisecondsSinceEpoch(
      timeInSeconds * 1000,
      isUtc: true,
    );
    print(parsed.toLocal().toString());

    final category = _box.get(key);
    category?.name = name;
    category?.save();
  }

  @override
  void writeCategory(Category category) => _box.add(category);
}
