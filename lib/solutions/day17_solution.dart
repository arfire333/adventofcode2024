import 'dart:math';

import 'package:adventofcode2024/mixins/solution.dart';

class Day17Solution with Solution {
  late Map<int, (String, int, Function())> operations;
  Day17Solution() {
    operations = {
      0: ('adv', 2, adv),
      1: ('bxl', 2, bxl),
      2: ('bst', 2, bst),
      3: ('jnz', 2, jnz),
      4: ('bxc', 2, bxc),
      5: ('out', 2, out),
      6: ('bdv', 2, bdv),
      7: ('cdv', 2, cdv)
    };
  }
  int A = -1;
  int B = -1;
  int C = -1;
  int givenA = -1;
  int givenB = -1;
  int givenC = -1;

  List<int> output = [];
  bool halt = false;

  int nextOpcode() {
    if (ip >= instructions.length) {
      halt = true;
      return -1;
    }
    return instructions[ip++];
  }

  int nextOperand() {
    if (ip >= instructions.length) {
      halt = true;
      return -1;
    }
    return instructions[ip++];
  }

  int nextCombo() {
    var operand = nextOperand();
    switch (operand) {
      case 0:
      case 1:
      case 2:
      case 3:
        return operand;
      case 4:
        return A;
      case 5:
        return B;
      case 6:
        return C;
      default:
        return 0;
    }
  }

  void adv() {
    var combo = nextCombo();
    var denominator = pow(2, combo);
    A = A ~/ denominator;
  }

  void bxl() {
    var literal = nextOperand();
    B = B ^ literal;
  }

  void bst() {
    var combo = nextCombo();
    B = combo % 8;
  }

  void jnz() {
    if (A == 0) {
      return;
    }
    var literal = nextOperand();
    ip = literal;
  }

  void bxc() {
    var _ = nextOperand();
    B = B ^ C;
  }

  void out() {
    var combo = nextCombo();
    output.add(combo % 8);
  }

  void bdv() {
    var combo = nextCombo();
    var denominator = pow(2, combo);
    B = A ~/ denominator;
  }

  void cdv() {
    var combo = nextCombo();
    var denominator = pow(2, combo);
    C = A ~/ denominator;
  }

  List<int> instructions = [];
  int ip = 0;

  @override
  int get year => 2024;

  @override
  int get day => 17;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    instructions = [];
    output = [];
    // Parse lines

    A = int.parse(lines[0].split(' ')[2]);
    B = int.parse(lines[1].split(' ')[2]);
    C = int.parse(lines[2].split(' ')[2]);
    givenA = A;
    givenB = B;
    givenC = C;

    var programLines = lines[4].split(' ')[1].split(',');
    for (var instruction in programLines) {
      instructions.add(int.parse(instruction));
    }

    dataIsValid = true;
  }

  String stringifyOutput() {
    String result = '';
    if (output.isNotEmpty) {
      result = '${output[0]}';
    }
    for (int i = 1; i < output.length; i++) {
      result = '$result,${output[i]}';
    }

    return result;
  }

  bool outputMatches() {
    if (output.length != instructions.length) {
      return false;
    }
    for (int i = 0; i < output.length; i++) {
      if (output[i] != instructions[i]) {
        return false;
      }
    }

    return true;
  }

  @override
  void part1() {
    var opcode = nextOpcode();
    while (!halt) {
      var currentOperation = operations[opcode]!.$3;
      currentOperation();
      opcode = nextOpcode();
    }

    answer1 = stringifyOutput();
  }

  bool isEqual(int digit) {
    if (output.length != instructions.length) {
      return false;
    }
    for (int i = digit; i < instructions.length; i++) {
      if (output[i] != instructions[i]) {
        return false;
      }
    }
    return true;
  }

  // This implementation derived from
  // https://www.reddit.com/r/adventofcode/comments/1hg38ah/comment/m2l7qx8/
  @override
  void part2() {
    int lastApproximation = 0;
    for (int digit = instructions.length - 1; digit >= 0; digit -= 1) {
      for (int i = 0; i < 10000000000000; i++) {
        var nextApproximation = lastApproximation + (1 << (digit * 3)) * i;
        A = nextApproximation;
        B = givenB;
        C = givenC;
        output = [];
        ip = 0;
        var opcode = nextOpcode();
        halt = false;
        while (!halt) {
          var currentOperation = operations[opcode]!.$3;
          currentOperation();
          opcode = nextOpcode();
        }
        if (isEqual(digit)) {
          lastApproximation = nextApproximation;
          break;
        }
      }
    }
    answer2 = '$lastApproximation';
  }
}
