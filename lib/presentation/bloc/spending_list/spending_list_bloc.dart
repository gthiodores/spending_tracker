import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:username_gen/username_gen.dart';
import 'package:uuid/uuid.dart';

import 'dummy_object.dart';

part 'spending_list_event.dart';

part 'spending_list_state.dart';

class SpendingListBloc extends Bloc<SpendingListEvent, SpendingListState> {
  SpendingListBloc()
      : super(
          const SpendingListState(
            isLoading: false,
            searchQuery: '',
            objects: [],
            filteredObjects: [],
          ),
        ) {
    on<SpendingListGenerate>(
      (event, emit) {
        emit(state.copyWith(isLoading: true, searchQuery: ''));
        final generated = List.generate(
          20000,
          (index) => DummyObject(
            name: UsernameGen().generate(),
            uuid: const Uuid().v4(),
            age: Random().nextInt(99),
          ),
        );
        emit(state.copyWith(objects: generated, filteredObjects: generated));
      },
      transformer: restartable(),
    );

    on<SpendingListFilter>(
      (event, emit) async {
        print('Filtering!');
        if (event.searchQuery.isEmpty) {
          emit(state.copyWith(filteredObjects: state.objects));
          return;
        }

        final time = Stopwatch()..start();

        emit(state.copyWith(isLoading: true));
        final filtered = List<DummyObject>.from(state.objects)
            .where(
              (element) =>
                  element.name
                      .toLowerCase()
                      .startsWith(event.searchQuery.toLowerCase()) ||
                  element.uuid
                      .toLowerCase()
                      .startsWith(event.searchQuery.toLowerCase()),
            )
            .toList();

        time.stop();
        print('time taken to filter: ${time.elapsed.inMilliseconds} ms');
        emit(state.copyWith(
          filteredObjects: filtered,
          message: 'Filter took ${time.elapsed.inMilliseconds} ms',
        ));
        await Future.delayed(
          const Duration(seconds: 2),
          () => emit(
            state.copyWith(
              message: 'Finished in ${time.elapsed.inMilliseconds} ms',
            ),
          ),
        );
      },
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }
}
