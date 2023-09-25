import 'package:dart_algorithms/mathExpression/operation.dart';
import 'package:test/test.dart';

void main() {
  group('Operation', () {
    group('constructor', () {
      test('constructor with default args', () {
        final op = Operation(OperationType.multiply);
        expect(
          op.type,
          equals(OperationType.multiply),
          reason: 'type should match',
        );
      });

      test('constructor with explicit weak arg', () {
        final op = Operation(OperationType.divide);
        expect(
          op.type,
          equals(OperationType.divide),
          reason: 'type should match',
        );
      });

      test('fromOpString pseudo constructor "Add"', () {
        final strongAdd = Operation.fromOpString('Add');
        expect(
          strongAdd.type,
          equals(OperationType.add),
          reason: 'should parse correct type',
        );
      });

      test('fromOpString pseudo constructor "sub"', () {
        final weakSub = Operation.fromOpString('sub');
        expect(
          weakSub.type,
          equals(OperationType.subtract),
          reason: 'should parse correct type',
        );
      });
    });

    group('instance methods', () {
      test('toOperationString', () {
        final mul = Operation(OperationType.multiply);
        final stringified = mul.toOperationString(6.toString(), 7.toString());
        expect(
          stringified,
          equals('( 6 * 7 )'),
          reason: 'should stringify operation',
        );
      });

      test('operate', () {
        final mul = Operation(OperationType.multiply);
        final opResult = mul.operate(6, 7);
        expect(
          opResult,
          equals(42),
          reason: 'should execute operation',
        );
      });
    });
  });
}
