import 'package:dart_algorithms/permutation/permutate.dart';

void main() {
  final List<int> data = [1, 2, 3, 4];

  final p = Permutator(data);

  final results = p.permutate(4, pickOnce: true);
  for (var element in results) {
    print(element.join(','));
  }
  print(results.length);
}
