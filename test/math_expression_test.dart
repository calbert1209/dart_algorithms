import 'package:dart_algorithms/mathExpression/operation.dart';
import 'package:dart_algorithms/mathExpression/math_expression.dart';
import 'package:test/test.dart';

void main() {
  group('MathExpression', () {
    const values = (1, 2, 3, 4);
    group('evaluate', () {
      test('basic (1)', () {
        final ops = (
          Operation.fromOpString('Add'),
          Operation.fromOpString('Mul'),
          Operation.fromOpString('Add'),
        );

        // 1 + ( ( 2 * 3 ) + 4 ) = 11
        final mathExp = MathExpression(
          values,
          ops,
          OperationOrder.yzx,
        );

        expect(mathExp.evaluate(), equals(11));
      });

      test('basic (2)', () {
        final ops = (
          Operation.fromOpString('Add'),
          Operation.fromOpString('add'),
          Operation.fromOpString('Mul'),
        );

        // (1 + 2) + (3 * 4) = 15
        final mathExp = MathExpression(
          values,
          ops,
          OperationOrder.xzy,
        );

        expect(mathExp.evaluate(), equals(15));
      });

      test('basic (3)', () {
        final ops = (
          Operation.fromOpString('Div'),
          Operation.fromOpString('Mul'),
          Operation.fromOpString('Mul'),
        );

        // (1 / 2) * (3 * 4) = 6.0
        final mathExp = MathExpression(
          values,
          ops,
          OperationOrder.xzy,
        );

        expect(mathExp.evaluate(), equals(6.0));
      });

      test('basic (4)', () {
        final ops = (
          Operation.fromOpString('Mul'),
          Operation.fromOpString('Sub'),
          Operation.fromOpString('Mul'),
        );

        // (4 * (1 - (2 * 3))) = -20
        final mathExp = MathExpression(
          (4, 1, 2, 3),
          ops,
          OperationOrder.zyx,
        );

        expect(mathExp.evaluate(), equals(-20));
      });

      test('should return infinity', () {
        final ops = (
          Operation.fromOpString('Div'),
          Operation.fromOpString('Mul'),
          Operation.fromOpString('Sub'),
        );

        // 1 / ((2 * 3) - 6) = 1 / 0
        final mathExp = MathExpression(
          (1, 2, 3, 6),
          ops,
          OperationOrder.yzx,
        );

        expect(mathExp.evaluate(), equals(double.infinity));
      });
    });

    group('toExpressionString', () {
      test('should return expression string', () {
        final ops = (
          Operation.fromOpString('Div'),
          Operation.fromOpString('Mul'),
          Operation.fromOpString('Mul'),
        );

        // (1 / 2) * (3 * 4) = 6.0
        final mathExp = MathExpression(
          values,
          ops,
          OperationOrder.xzy,
        );

        expect(mathExp.toExpressionString(), equals('( 1 / 2 ) * ( 3 * 4 )'));
      });
    });
  });
}
