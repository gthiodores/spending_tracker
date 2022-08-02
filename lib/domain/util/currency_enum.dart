import 'package:hive_flutter/hive_flutter.dart';

part 'currency_enum.g.dart';

@HiveType(typeId: 0)
enum CurrencyEnum {
  @HiveField(0, defaultValue: true)
  idr("Rp", "Indonesian Rupiah"),
  @HiveField(1)
  usd("USD", "US Dollar");

  final String symbol;
  final String name;

  const CurrencyEnum(this.symbol, this.name);
}
