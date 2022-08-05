import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_3_testing/data/model/spending.dart';
import 'package:rxdart/rxdart.dart';

abstract class SpendingLocalSourceBase {
  Stream<List<Spending>> watchRecentSpending({int? limit});

  Future<List<Spending>> getSpendingInTimeRange(DateTimeRange timeRange);
}

class SpendingLocalSource extends SpendingLocalSourceBase {
  final LazyBox<Spending> _box;

  SpendingLocalSource(this._box);

  @override
  Future<List<Spending>> getSpendingInTimeRange(DateTimeRange timeRange) async {
    final items = await _takeSpending();

    return items
        .where((element) =>
            element.created.isBefore(timeRange.end) &&
            element.created.isAfter(timeRange.start))
        .toList();
  }

  @override
  Stream<List<Spending>> watchRecentSpending({int? limit}) async* {
    final initialData = await _takeSpending(limit: limit);

    yield* _box.watch().switchMap((event) async* {
      yield await _takeSpending(limit: limit);
    }).startWith(initialData);
  }

  Future<List<Spending>> _takeSpending({int? limit}) async {
    Iterable<dynamic> keys = _box.keys;

    if (limit != null) {
      int count = keys.length - limit;
      keys = keys.skip(count >= 0 ? count : 0);
    }

    final List<Spending> items = [];

    for (final key in keys) {
      final value = await _box.get(key);

      if (value == null) continue;

      items.add(value);
    }

    return items;
  }
}
