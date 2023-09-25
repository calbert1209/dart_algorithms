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
