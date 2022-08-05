import 'package:equatable/equatable.dart';

class UiCategory extends Equatable {
  final dynamic key;
  final String name;
  final DateTime createdAt;

  const UiCategory({
    required this.key,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [key, name, createdAt];
}
