// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpendingAdapter extends TypeAdapter<Spending> {
  @override
  final int typeId = 2;

  @override
  Spending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spending(
      amount: fields[0] as double,
      currencySymbol: fields[1] as String,
      category: fields[2] as Category?,
      created: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Spending obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.currencySymbol)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
