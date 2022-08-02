import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime created;

  Category({
    this.name = '',
    required this.created,
  });
}
