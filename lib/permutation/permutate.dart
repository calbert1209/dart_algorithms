class Permutator<T> {
  final List<T> list;

  Permutator(this.list);

  void _permutateRecursively(List<T> prefix, List<T> options, int length,
      List<List<T>> target, List<T> Function(List<T>, int index) onPick) {
    if (prefix.length == length) {
      target.add(prefix);
      return;
    }

    for (var i = 0; i < options.length; i++) {
      final option = options[i];
      final remainder = onPick(options, i);
      final result = List<T>.from(prefix)..add(option);

      _permutateRecursively(result, remainder, length, target, onPick);
    }
  }

  List<List<T>> permutate(int length, {bool pickOnce = false}) {
    final output = <List<T>>[];

    final onPick = pickOnce
        ? (List<T> options, int index) => List<T>.from(options)..removeAt(index)
        : (List<T> options, int _) => List<T>.from(options);
    _permutateRecursively(List<T>.empty(), list, length, output, onPick);

    return output;
  }
}
