import 'package:dart_algorithms/unionFind/quick_find.dart';
import 'package:test/test.dart';

void main() {
  var connections = [
    [0, 1],
    [1, 2],
    [3, 4],
    [0, 5],
    [1, 6],
    [2, 7],
    [3, 8],
    [4, 9]
  ];

  group('QuickFind.union', () {
    var uf = QuickFind(10);
    for (var edge in connections) {
      uf.union(edge[0], edge[1]);
    }
    for (var edge in connections) {
      test('should connect objects ${edge[0]}-${edge[1]}', () {
        expect(uf.list[edge[0]], uf.list[edge[1]]);
      });
    }
  });

  group('QuickFind.connected', () {
    var uf = QuickFind(10);
    for (var edge in connections) {
      uf.union(edge[0], edge[1]);
    }
    for (var edge in connections) {
      test('should connect objects ${edge[0]}-${edge[1]}', () {
        expect(uf.connected(edge[0], edge[1]), true);
      });
    }
  });
}
