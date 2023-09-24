import 'package:dart_algorithms/mathExpression/math_expression.dart';
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
      print(exp.substring(2, 23));
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
    'mul',
    'div',
    'add',
    'sub',
  ]);

  final valueLists = valueP.permutate(4, pickOnce: true);
  final opsLists = opsP.permutate(3, pickOnce: false);

  OptionDict options = {};

  addOption(num value, String expression) {
    if (!options.keys.contains(value)) {
      options[value] = List<String>.empty(growable: true);
    }

    options[value]!.add(expression);
  }

  for (var opsList in opsLists) {
    for (var valueList in valueLists) {
      final ops = opsList.map((e) => Operation.fromOpString(e)).toList();
      // final priorities = ops.map((e) => e.priority.index).toList();
      final exp = MathExpression.create(valueList, ops);

      final evaluatedResult = exp.evaluate();
      final expressionString = exp.toExpressionString();
      // print(
      //     '${valueList.join(',')} ${opsList.join(',')} $evaluatedResult ${priorities.join(',')} $expressionString');
      if (evaluatedResult.isFinite &&
          !evaluatedResult.isNaN &&
          evaluatedResult.toInt() == evaluatedResult) {
        addOption(evaluatedResult, expressionString);
      }
    }
  }

  reportCounts(options);
  reportAnswers(options);
}
