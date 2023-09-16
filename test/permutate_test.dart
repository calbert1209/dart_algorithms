import 'package:dart_algorithms/permutation/permutate.dart';
import 'package:test/test.dart';
import 'permutation_example_lists.dart' as samples;
import 'test_utilities.dart';

void main() {
  group((Permutator).toString(), () {
    test('constructor', () {
      final seedList = [1, 2, 3, 4];
      final p = Permutator(seedList);
      expect(p.runtimeType.toString(), "Permutator<int>");
      expectListsEqual(seedList, p.list);
    });

    test('permutate without pickOnce', () {
      final seedList = [1, 2, 3, 4];
      final p = Permutator(seedList);
      expectListsEqual(
        p.permutate(4),
        samples.exaustiveWithRePick,
      );
    });

    test('permutate with pickOnce', () {
      final seedList = [1, 2, 3, 4];
      final p = Permutator(seedList);
      expectListsEqual(
        p.permutate(4, pickOnce: true),
        samples.exhaustiveListWithoutRePick,
      );
    });
  });
}
