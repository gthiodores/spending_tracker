part of 'spending_category_cubit.dart';

class SpendingCategoryState extends Equatable {
  final List<Category> categories;
  final Category? previouslyDeleted;
  final String? message;

  const SpendingCategoryState({
    required this.categories,
    this.previouslyDeleted,
    this.message,
  });

  SpendingCategoryState.initial()
      : categories = [],
        previouslyDeleted = null,
        message = null;

  SpendingCategoryState copyWith({
    List<Category>? categories,
    Category? previouslyDeleted,
    String? message,
  }) =>
      SpendingCategoryState(
        categories: categories ?? this.categories,
        message: message,
        previouslyDeleted: previouslyDeleted,
      );

  @override
  List<Object?> get props => [categories, previouslyDeleted, message];
}
