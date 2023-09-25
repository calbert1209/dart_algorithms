import 'dart:math';

enum OperationType {
  multiply,
  divide,
  add,
  subtract,
}

enum OperationPriority {
  low,
  medium,
  high,
  highest,
}

class Operation {
  static Map<OperationType, String> operandSymbol = {
    OperationType.multiply: '*',
    OperationType.divide: '/',
    OperationType.add: '+',
    OperationType.subtract: '-',
  };

  static Map<OperationType, num Function(num a, num b)> mathOp = {
    OperationType.multiply: (a, b) => a * b,
    OperationType.divide: (a, b) => a / b,
    OperationType.add: (a, b) => a + b,
    OperationType.subtract: (a, b) => a - b,
  };

  final OperationType type;
  final bool weak;

  Operation(this.type, {this.weak = false});

  String toOperationString(dynamic a, dynamic b) {
    return '( ${a.toString()} ${operandSymbol[type]} ${b.toString()} )';
  }

  num operate(num a, num b) {
    return mathOp[type]!(a, b);
  }

  OperationPriority get priority {
    switch (type) {
      case OperationType.multiply:
      case OperationType.divide:
        return weak ? OperationPriority.medium : OperationPriority.highest;
      case OperationType.add:
      case OperationType.subtract:
        return weak ? OperationPriority.low : OperationPriority.high;
      default:
        throw Exception('invalid type: $type');
    }
  }

  static Operation fromOpString(String op) {
    switch (op) {
      case 'Mul':
        return Operation(OperationType.multiply, weak: false);
      case 'Div':
        return Operation(OperationType.divide, weak: false);
      case 'Add':
        return Operation(OperationType.add, weak: false);
      case 'Sub':
        return Operation(OperationType.subtract, weak: false);
      case 'mul':
        return Operation(OperationType.multiply, weak: true);
      case 'div':
        return Operation(OperationType.divide, weak: true);
      case 'add':
        return Operation(OperationType.add, weak: true);
      case 'sub':
        return Operation(OperationType.subtract, weak: true);
      default:
        throw Exception('Invalid op string: "$op"');
    }
  }
}

class SortableOperation {
  final Operation op;
  final int sequenceIndex;

  SortableOperation(this.op, this.sequenceIndex);

  int compareTo(SortableOperation other) {
    return op.priority.index - other.op.priority.index;
  }
}

class MathExpression {
  final List<int> values;
  final List<SortableOperation> ops;

  MathExpression._(this.values, this.ops);

  static _sortOps(List<Operation> ops) {
    return List<SortableOperation>.generate(
      ops.length,
      (index) => SortableOperation(ops[index], index),
    )..sort(
        (a, b) => b.compareTo(a),
      );
  }

  static MathExpression create(List<int> values, List<Operation> ops) {
    final sortedOps = _sortOps(ops);
    return MathExpression._(values, sortedOps);
  }

  T _evaluate<T>(List<T> seedValues,
      T Function(T a, T b) Function(Operation op) getAction) {
    final results = List<T>.from(seedValues);
    final isFirstOpZOp = ops[0].sequenceIndex == 2;
    for (var sortedOpIndex = 0; sortedOpIndex < ops.length; sortedOpIndex++) {
      final currentOp = ops[sortedOpIndex];
      final is2ndOp = sortedOpIndex == 1;
      final isYOp = currentOp.sequenceIndex == 1;
      final yOpSecondAfterInitialZOp = is2ndOp && isYOp && isFirstOpZOp;
      final aIndex = yOpSecondAfterInitialZOp
          ? 1
          : max(0, currentOp.sequenceIndex - sortedOpIndex);
      final bIndex = aIndex + 1;
      final action = getAction(currentOp.op);
      results[aIndex] = action(
        results[aIndex],
        results[bIndex],
      );
      results.removeAt(bIndex);
    }

    return results[0];
  }

  num evaluate() {
    final results = List<num>.from(values);
    return _evaluate(results, (op) => op.operate);
  }

  String toExpressionString() {
    final results =
        List.generate(values.length, ((index) => values[index].toString()));
    return _evaluate(results, (op) => op.toOperationString);
  }
}
