import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/spending.dart';
import 'package:rxdart/rxdart.dart';

abstract class SpendingLocalSourceBase {
  Stream<List<Spending>> watchRecentSpending(int limit);

  List<Spending> getSpendingInTimeRange(DateTimeRange timeRange);
}

class SpendingLocalSource extends SpendingLocalSourceBase {
  final LazyBox<Spending> _box;

  SpendingLocalSource(this._box);

  @override
  List<Spending> getSpendingInTimeRange(DateTimeRange timeRange) {
    throw UnimplementedError('not yet implemented');
    // return _box
    //     .where((element) => element.created.isBefore(timeRange.end))
    //     .where((element) => element.created.isAfter(timeRange.start))
    //     .toList();
  }

  @override
  Stream<List<Spending>> watchRecentSpending(int limit) async* {
    final initialData = await _takeLatestSpending(limit);

    yield* _box.watch().switchMap((event) async* {
      final spending = await _takeLatestSpending(limit);
      yield spending;
    }).startWith(initialData);
  }

  Future<List<Spending>> _takeLatestSpending(int limit) async {
    final box = await Hive.openBox<Spending>('spending');

    final values = box.values.take(limit).toList();
    box.close();

    return values.take(5).toList();
  }
}
