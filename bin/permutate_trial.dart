import 'package:dart_algorithms/mathExpression/math_expression.dart';
import 'package:dart_algorithms/permutation/permutate.dart';

typedef Option = (int, String);

bool isInteger(num value) => value is int || value == value.roundToDouble();

void main() {
  final valueP = Permutator([1, 2, 3, 4]);
  final opsP = Permutator([
    'Mul',
    'Div',
    'Add',
    'Sub',
    'mul',
    'div',
    'add',
    'sub',
  ]);

  final valueLists = valueP.permutate(4, pickOnce: true);
  final opsLists = opsP.permutate(3, pickOnce: false);

  final options = List<Option>.empty(growable: true);

  for (var opsList in opsLists) {
    for (var valueList in valueLists) {
      final ops = opsList.map((e) => Operation.fromOpString(e)).toList();
      final exp = MathExpression.create(valueList, ops);

      final evaluatedResult = exp.evaluate();
      final expressionString = exp.toExpressionString();
      if (isInteger(evaluatedResult) &&
          evaluatedResult.isFinite &&
          !evaluatedResult.isNaN) {
        options.add((evaluatedResult.toInt(), expressionString));
      }
    }
  }

  print("=== Sorting... ====================");

  final sortedOptions = options
    ..sort((a, b) {
      var (valueA, _) = a;
      var (valueB, _) = b;
      return (valueB - valueA).toInt();
    });

  for (var (value, expression) in sortedOptions) {
    print('$expression = ${value.toInt()}');
  }
}
