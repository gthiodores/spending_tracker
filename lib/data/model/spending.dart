import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'spending.g.dart';

@HiveType(typeId: 2)
class Spending extends HiveObject {
  @HiveField(0)
  double amount;

  @HiveField(1)
  String currencySymbol;

  @HiveField(2, defaultValue: null)
  Category? category;

  @HiveField(3)
  DateTime created;

  @HiveField(4)
  String? note;

  Spending({
    this.amount = 0,
    this.currencySymbol = 'Rp',
    this.category,
    required this.created,
    this.note,
  });
}
