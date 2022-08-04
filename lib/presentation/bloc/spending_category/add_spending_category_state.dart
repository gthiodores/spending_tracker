part of 'add_spending_category_cubit.dart';

class AddSpendingCategoryState extends Equatable {
  final String name;
  final String? message;
  final bool isLoading;
  final bool success;

  const AddSpendingCategoryState({
    required this.name,
    this.isLoading = false,
    this.message,
    this.success = false,
  });

  AddSpendingCategoryState copyWith({
    String? name,
    String? message,
    bool? isLoading,
    bool? success,
  }) =>
      AddSpendingCategoryState(
        name: name ?? this.name,
        message: message,
        isLoading: isLoading ?? this.isLoading,
        success: success ?? this.success,
      );

  @override
  List<Object?> get props => [name, isLoading, message, success];
}
