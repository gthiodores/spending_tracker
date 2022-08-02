import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'spending_category_event.dart';
part 'spending_category_state.dart';

class SpendingCategoryBloc extends Bloc<SpendingCategoryEvent, SpendingCategoryState> {
  SpendingCategoryBloc() : super(SpendingCategoryInitial()) {
    on<SpendingCategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
