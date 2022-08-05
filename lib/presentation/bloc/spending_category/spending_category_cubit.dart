import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/domain/model/ui_category.dart';
import 'package:material_3_testing/domain/use_case/category/delete_category.dart';
import 'package:material_3_testing/domain/use_case/category/get_categories.dart';
import 'package:material_3_testing/domain/use_case/category/insert_category.dart';

part 'spending_category_state.dart';

class SpendingCategoryCubit
    extends Bloc<SpendingCategoryEvent, SpendingCategoryState> {
  final GetCategories _getCategories;
  final DeleteCategory _deleteCategory;
  final InsertCategory _insertCategory;

  SpendingCategoryCubit(
    this._getCategories,
    this._deleteCategory,
    this._insertCategory,
  ) : super(SpendingCategoryState.initial()) {
    on<SpendingCategoryInit>((event, emit) {
      return emit.forEach(
        _getCategories.execute(),
        onData: (List<Category> data) {
          final items = data
              .map((e) =>
                  UiCategory(key: e.key, name: e.name, createdAt: e.created))
              .toList();
          items.sort((a, b) => a.createdAt.isAfter(b.createdAt) ? 1 : 0);

          return state.copyWith(
            categories: items,
            previouslyDeleted: state.previouslyDeleted,
          );
        },
      );
    });

    on<SpendingCategoryDelete>((event, emit) {
      _deleteCategory.execute(event.category.key);
      emit(state.copyWith(
        previouslyDeleted: Category(
          name: event.category.name,
          created: event.category.createdAt,
        ),
        message: 'Category ${event.category.name} deleted',
      ));
    });

    on<SpendingCategoryUndoDelete>((event, emit) {
      if (state.previouslyDeleted == null) {
        emit(state.copyWith(message: 'Failed to restore category'));
        return;
      }

      _insertCategory.execute(state.previouslyDeleted!);
      emit(state.copyWith(message: "Category restored"));
    });
  }
}

abstract class SpendingCategoryEvent extends Equatable {}

class SpendingCategoryInit extends SpendingCategoryEvent {
  @override
  List<Object?> get props => [];
}

class SpendingCategoryDelete extends SpendingCategoryEvent {
  final UiCategory category;

  SpendingCategoryDelete(this.category);

  @override
  List<Object?> get props => [category];
}

class SpendingCategoryUndoDelete extends SpendingCategoryEvent {
  @override
  List<Object?> get props => [];
}
