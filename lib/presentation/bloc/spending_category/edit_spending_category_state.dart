part of 'edit_spending_category_cubit.dart';

class EditSpendingCategoryState extends Equatable {
  final String name;
  final String? message;
  final bool isLoading;
  final bool success;

  const EditSpendingCategoryState({
    required this.name,
    this.message,
    this.isLoading = false,
    this.success = false,
  });

  const EditSpendingCategoryState.initial(this.name)
      : message = null,
        isLoading = false,
        success = false;

  EditSpendingCategoryState copyWith({
    String? name,
    String? message,
    bool? isLoading,
    bool? success,
  }) =>
      EditSpendingCategoryState(
          name: name ?? this.name,
          message: message,
          isLoading: isLoading ?? false,
          success: success ?? false);

  @override
  List<Object?> get props => [name, message, isLoading, success];
}
