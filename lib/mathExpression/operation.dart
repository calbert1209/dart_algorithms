enum OperationType {
  multiply,
  divide,
  add,
  subtract,
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

  Operation(this.type);

  String toOperationString(dynamic a, dynamic b) {
    return '( ${a.toString()} ${operandSymbol[type]} ${b.toString()} )';
  }

  num operate(num a, num b) {
    return mathOp[type]!(a, b);
  }

  static Operation fromOpString(String op) {
    final lowerCaseOp = op.toLowerCase();
    switch (lowerCaseOp) {
      case 'mul':
        return Operation(OperationType.multiply);
      case 'div':
        return Operation(OperationType.divide);
      case 'add':
        return Operation(OperationType.add);
      case 'sub':
        return Operation(OperationType.subtract);
      default:
        throw Exception('Invalid op string: "$op"');
    }
  }
}
