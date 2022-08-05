import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/use_case/preference/get_preferred_currency.dart';
import 'package:material_3_testing/domain/util/currency_enum.dart';

part 'add_spending_event.dart';

part 'add_spending_state.dart';

class AddSpendingBloc extends Bloc<AddSpendingEvent, AddSpendingState> {
  AddSpendingBloc(
    GetPreferredCurrency getPreferredCurrency,
  ) : super(AddSpendingState.initial(getPreferredCurrency.execute())) {
    on<AddSpendingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
