part of 'spending_list_bloc.dart';

abstract class SpendingListEvent extends Equatable {
  const SpendingListEvent();
}

class SpendingListGenerate extends SpendingListEvent {
  @override
  List<Object?> get props => [];
}

class SpendingListFilter extends SpendingListEvent {
  final String searchQuery;

  const SpendingListFilter(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}
