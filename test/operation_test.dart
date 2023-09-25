import 'package:dart_algorithms/mathExpression/operation.dart';
import 'package:test/test.dart';

void main() {
  group((Operation).toString(), () {
    group('constructor', () {
      test('constructor with default args', () {
        final op = Operation(OperationType.multiply);
        expect(
          op.type,
          equals(OperationType.multiply),
          reason: 'type should match',
        );
        expect(
          op.weak,
          equals(false),
          reason: 'should be false',
        );
      });

      test('constructor with explicit weak arg', () {
        final op = Operation(OperationType.divide, weak: true);
        expect(
          op.type,
          equals(OperationType.divide),
          reason: 'type should match',
        );
        expect(
          op.weak,
          equals(true),
          reason: '`weak` should be true',
        );
      });

      test('fromOpString pseudo constructor "Add"', () {
        final strongAdd = Operation.fromOpString('Add');
        expect(
          strongAdd.type,
          equals(OperationType.add),
          reason: 'should parse correct type',
        );
        expect(
          strongAdd.weak,
          equals(false),
          reason: 'should parse as strong operation',
        );
      });

      test('fromOpString pseudo constructor "sub"', () {
        final weakSub = Operation.fromOpString('sub');
        expect(
          weakSub.type,
          equals(OperationType.subtract),
          reason: 'should parse correct type',
        );
        expect(
          weakSub.weak,
          equals(true),
          reason: 'should parse as strong operation',
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

      test('priority - strong multiply', () {
        final mul = Operation(OperationType.multiply);
        expect(
          mul.priority,
          equals(OperationPriority.highest),
          reason: 'should return highest priority',
        );
      });

      test('priority - weak multiply', () {
        final mul = Operation(OperationType.multiply, weak: true);
        expect(
          mul.priority,
          equals(OperationPriority.medium),
          reason: 'should return medium priority',
        );
      });
    });
  });
}
