import 'package:dart_algorithms/mathExpression/operation.dart';
import 'package:dart_algorithms/mathExpression/math_expression.dart';

void main(List<String> args) {
  final values = (1, 4, 2, 3);
  final ops = (
    Operation.fromOpString('Sub'),
    Operation.fromOpString('Add'),
    Operation.fromOpString('Mul'),
  );
  final order = OperationOrder.yxz;

  final mathExp = MathExpression(values, ops, order);
  final result = mathExp.evaluate();
  final process = mathExp.toExpressionString();
  print('$process = $result');
}
