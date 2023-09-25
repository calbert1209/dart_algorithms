import 'package:dart_algorithms/mathExpression/operation.dart';

enum OperationOrder {
  xyz,
  xzy,
  yzx,
  yxz,
  zyx,
}

// use existing implementation of Operation Type
typedef ValuesTuple = (int, int, int, int);
typedef OpsTuple = (Operation, Operation, Operation);
typedef MathOperation = num Function(num a, num b);

class NeoMathExpression {
  final ValuesTuple values;
  final OpsTuple ops;
  final OperationOrder _order;

  NeoMathExpression(this.values, this.ops, this._order);

  T _executeInOrder<T>(
    (T, T, T, T) valuesTuple,
    T Function(T a, T b) Function(Operation op) getAction,
  ) {
    final (a, b, c, d) = valuesTuple;
    final x = getAction(ops.$1);
    final y = getAction(ops.$2);
    final z = getAction(ops.$3);
    switch (_order) {
      case OperationOrder.xyz:
        return z(y(x(a, b), c), d);
      case OperationOrder.xzy:
        return y(x(a, b), z(c, d));
      case OperationOrder.yxz:
        return z(x(a, y(b, c)), d);
      case OperationOrder.yzx:
        return x(a, z(y(b, c), d));
      case OperationOrder.zyx:
        return x(a, y(b, z(c, d)));
      default:
        throw Exception('Invalid OperationOrder: $_order');
    }
  }

  num evaluate() {
    return _executeInOrder<num>(
      values,
      (op) => op.operate,
    );
  }

  String toExpressionString() {
    final valueStringTuple = (
      '${values.$1}',
      '${values.$2}',
      '${values.$3}',
      '${values.$4}',
    );

    final expression = _executeInOrder<String>(
      valueStringTuple,
      (op) => op.toOperationString,
    );

    return expression.substring(2, 23);
  }
}
