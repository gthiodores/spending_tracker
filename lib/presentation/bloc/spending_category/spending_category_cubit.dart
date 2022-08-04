import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/domain/use_case/category/delete_category.dart';
import 'package:material_3_testing/domain/use_case/category/get_categories.dart';
import 'package:material_3_testing/domain/use_case/category/insert_category.dart';

part 'spending_category_state.dart';

class SpendingCategoryCubit extends Cubit<SpendingCategoryState> {
  final GetCategories _getCategories;
  final DeleteCategory _deleteCategory;
  final InsertCategory _insertCategory;

  SpendingCategoryCubit(
    this._getCategories,
    this._deleteCategory,
    this._insertCategory,
  ) : super(SpendingCategoryState.initial());

  void fetchCategories() {
    final categories = _getCategories.execute()
      ..sort((a, b) => a.created.isAfter(b.created) ? 1 : 0);
    emit(state.copyWith(categories: categories));
  }

  void deleteCategory(Category category) {
    _deleteCategory.execute(category);
    fetchCategories();
    emit(state.copyWith(
      previouslyDeleted: category,
      message: 'Category ${category.name} deleted',
    ));
  }

  void addedSuccess() {
    fetchCategories();
  }

  void undoDeleteCategory() {
    if (state.previouslyDeleted == null) {
      emit(state.copyWith(message: 'Failed to restore category'));
      return;
    }

    _insertCategory.execute(state.previouslyDeleted!);
    fetchCategories();
    emit(state.copyWith(message: "Category restored"));
  }
}
