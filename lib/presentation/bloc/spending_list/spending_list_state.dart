part of 'spending_list_bloc.dart';

abstract class SpendingListState extends Equatable {
  const SpendingListState();
}

class SpendingListInitial extends SpendingListState {
  @override
  List<Object> get props => [];
}
