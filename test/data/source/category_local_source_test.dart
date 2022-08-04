import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/data/source/local/category_local_source.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box<Category> {}

void main() {
  late Box<Category> mockBox;
  late CategoryLocalSource sut;

  setUp(() {
    mockBox = MockBox();
    sut = CategoryLocalSource(mockBox);
  });

  test('should call box get', () {
    // arrange
    when(() => mockBox.values.toList()).thenReturn([]);

    // act
    final categories = sut.getCategories();

    // assert
    expect(categories, []);
    verify(() => mockBox.values).called(1);
  });
}
