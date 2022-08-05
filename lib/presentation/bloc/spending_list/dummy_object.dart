import 'package:equatable/equatable.dart';

class DummyObject extends Equatable {
  final String name;
  final String uuid;
  final int age;

  const DummyObject({
    required this.name,
    required this.uuid,
    required this.age,
  });

  @override
  List<Object?> get props => [name, uuid, age];
}
