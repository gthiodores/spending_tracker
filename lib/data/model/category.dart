import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject with EquatableMixin {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime created;

  Category({
    required this.name,
    required this.created,
  });

  @override
  List<Object?> get props => [name, created];
}
