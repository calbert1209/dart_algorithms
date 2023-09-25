import 'package:dart_algorithms/mathExpression/math_expression.dart';
import 'package:dart_algorithms/mathExpression/operation.dart';
import 'package:dart_algorithms/permutation/permutate.dart';

typedef OptionDict = Map<num, List<String>>;

bool isInteger(num value) => value is int || value == value.roundToDouble();

void reportAnswers(OptionDict options) {
  final sortedKeysByValueCount = options.keys.toList()
    ..sort((a, b) {
      final diff = options[b]!.length - options[a]!.length;
      if (diff == 0) {
        return (b - a).toInt();
      }

      return diff;
    });

  for (var key in sortedKeysByValueCount) {
    print('::: $key (${options[key]!.length}) '.padRight(40, ':'));
    for (var exp in options[key]!) {
      print(exp);
    }

    print('');
  }
}

void reportCounts(OptionDict options) {
  final sortedKeysByValueCount = options.keys.toList()
    ..sort((a, b) {
      final diff = options[b]!.length - options[a]!.length;
      if (diff == 0) {
        return (b - a).toInt();
      }

      return diff;
    });

  print('::: questions '.padRight(40, ':'));
  for (var key in sortedKeysByValueCount) {
    print('$key: ${options[key]!.length} '.padLeft(2, ' '));
  }
  print('');
}

void main() {
  final valueP = Permutator([1, 2, 3, 4]);
  final opsP = Permutator([
    'Mul',
    'Div',
    'Add',
    'Sub',
  ]);

  final valueLists = valueP.permutate(4, pickOnce: true).map((list) {
    final [a, b, c, d] = list;
    return (a, b, c, d);
  });
  final opsLists = opsP.permutate(3, pickOnce: false);
  final orders = [
    OperationOrder.xyz,
    OperationOrder.xzy,
    OperationOrder.yxz,
    OperationOrder.yzx,
    OperationOrder.zyx,
  ];

  OptionDict options = {};

  addOption(num value, String expression) {
    if (!options.keys.contains(value)) {
      options[value] = List<String>.empty(growable: true);
    }

    options[value]!.add(expression);
  }

  for (var opsList in opsLists) {
    for (var valueList in valueLists) {
      for (var order in orders) {
        final [x, y, z] =
            opsList.map((e) => Operation.fromOpString(e)).toList();
        final ops = (x, y, z);

        final exp = MathExpression(valueList, ops, order);
        final evaluatedResult = exp.evaluate();
        final expressionString = exp.toExpressionString();
        if (evaluatedResult.isFinite &&
            !evaluatedResult.isNaN &&
            evaluatedResult.toInt() == evaluatedResult) {
          addOption(evaluatedResult, expressionString);
        }
      }
    }
  }

  reportCounts(options);
  reportAnswers(options);
}
