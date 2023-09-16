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

  toOperationString(dynamic a, dynamic b) {
    return '( ${a.toString()} ${operandSymbol[type]} ${b.toString()} )';
  }

  operate(num a, num b) {
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
        throw Exception('invalid type');
    }
  }
}
