part of 'add_spending_bloc.dart';

class AddSpendingState extends Equatable {
  final String notes;
  final CurrencyEnum currency;
  final double amount;
  final Category? category;
  final bool isLoading;
  final String? message;

  const AddSpendingState({
    required this.notes,
    required this.currency,
    required this.amount,
    this.category,
    this.isLoading = false,
    this.message,
  });

  const AddSpendingState.initial(this.currency)
      : notes = '',
        message = null,
        amount = 0,
        isLoading = false,
        category = null;

  AddSpendingState copyWith({
    String? notes,
    CurrencyEnum? currency,
    double? amount,
    Category? category,
    bool? isLoading,
    String? message,
  }) =>
      AddSpendingState(
        notes: notes ?? this.notes,
        currency: currency ?? this.currency,
        amount: amount ?? this.amount,
        isLoading: isLoading ?? false,
        category: category ?? this.category,
        message: message,
      );

  AddSpendingState dropCategory() => AddSpendingState(
        notes: notes,
        currency: currency,
        amount: amount,
        category: null,
        isLoading: false,
        message: message,
      );

  @override
  List<Object?> get props => [
        notes,
        currency,
        amount,
        category,
        isLoading,
        message,
      ];
}
