import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'spending_list_event.dart';
part 'spending_list_state.dart';

class SpendingListBloc extends Bloc<SpendingListEvent, SpendingListState> {
  SpendingListBloc() : super(SpendingListInitial()) {
    on<SpendingListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
