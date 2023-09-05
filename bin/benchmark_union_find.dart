import 'dart:math';

import 'package:benchmarking/benchmarking.dart';
import 'package:dart_algorithms/unionFind/quick_find.dart';

List<int> pickTwoNumbers(int limit) {
  final r = Random();
  var first = r.nextInt(limit);
  var second = r.nextInt(limit);

  while (second == first) {
    second = r.nextInt(limit);
  }

  return [first, second];
}

void benchmarkUnionFind() {
  final limit = 10000;
  final numbers = List.generate(limit, (i) => i);
  final qf = QuickFind(limit);

  print('quickFind Insert...');
  syncBenchmark('QuickFind Insert', () {
    for (int i = 0; i < numbers.length; i++) {
      var picks = pickTwoNumbers(limit);
      qf.union(picks[0], picks[1]);
    }
  }).report(units: numbers.length);

  print('\nquickFind find...');
  syncBenchmark('QuickFind Insert', () {
    for (int i = 0; i < numbers.length; i++) {
      var picks = pickTwoNumbers(limit);
      qf.connected(picks[0], picks[1]);
    }
  }).report(units: numbers.length);
}
