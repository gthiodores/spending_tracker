import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/model/ui_category.dart';
import 'package:material_3_testing/domain/use_case/category/update_category.dart';

part 'edit_spending_category_state.dart';

class EditSpendingCategoryCubit extends Cubit<EditSpendingCategoryState> {
  final UiCategory category;
  final UpdateCategory _updateCategory;

  EditSpendingCategoryCubit(
    this.category,
    this._updateCategory,
  ) : super(EditSpendingCategoryState.initial(category.name));

  void updateName(String name) => emit(state.copyWith(name: name));

  void saveCategory() {
    emit(state.copyWith(isLoading: true));

    if (state.name.isEmpty) {
      emit(state.copyWith(message: 'Name cannot be empty'));
      return;
    }
    _updateCategory.execute(category.key, state.name);
    emit(state.copyWith(success: true));
  }
}
