part of 'add_spending_bloc.dart';

abstract class AddSpendingEvent extends Equatable {
  const AddSpendingEvent();
}

class AddSpendingCurrency extends AddSpendingEvent {
  final CurrencyEnum currency;

  const AddSpendingCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

class AddSpendingNotes extends AddSpendingEvent {
  final String notes;

  const AddSpendingNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}

class AddSpendingCategory extends AddSpendingEvent {
  final Category? category;

  const AddSpendingCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class AddSpendingAmount extends AddSpendingEvent {
  final double amount;

  const AddSpendingAmount(this.amount);

  @override
  List<Object?> get props => [amount];
}

class AddSpendingConfirm extends AddSpendingEvent {
  @override
  List<Object?> get props => [];
}
