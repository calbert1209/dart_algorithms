import 'package:dart_algorithms/unionFind/union_find.dart';

class QuickFind implements IUnionFind {
  List<int> list;
  QuickFind(int count) : list = List.generate(count, ((index) => index));

  /// complexity is O(1) :)
  @override
  bool connected(int p, int q) {
    return list[p] == list[q];
  }

  /// Merge components containing `p` and `q`,
  /// change all entries whose id equals `list[p]`
  /// to equal `list[q]`
  /// complexity is O(n^2) :(
  @override
  void union(int p, int q) {
    var nextList = list.map((e) => e == list[p] ? list[q] : e).toList();
    list = nextList;
  }
}
