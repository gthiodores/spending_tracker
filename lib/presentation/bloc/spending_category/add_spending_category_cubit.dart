import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/data/model/category.dart';
import 'package:material_3_testing/domain/use_case/category/insert_category.dart';

part 'add_spending_category_state.dart';

class AddSpendingCategoryCubit extends Cubit<AddSpendingCategoryState> {
  final InsertCategory _insertCategory;

  AddSpendingCategoryCubit(this._insertCategory)
      : super(const AddSpendingCategoryState(name: ''));

  void updateName(String name) => emit(state.copyWith(name: name));

  void saveCategory() {
    emit(state.copyWith(isLoading: true));

    if (state.name.isEmpty) {
      emit(state.copyWith(isLoading: false, message: 'Name cannot be empty'));
      return;
    }

    _insertCategory.execute(
      Category(name: state.name, created: DateTime.now()),
    );

    emit(state.copyWith(isLoading: false, success: true));
  }
}
