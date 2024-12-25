import 'dart:io';

import 'package:adventofcode2024/mixins/solution.dart';
import 'package:collection/collection.dart';

class Node {
  final String name;
  String? operator;
  Node? parent;
  Node? left;
  Node? right;
  int value;

  bool isValid() {
    bool retval = true;
    if (isInput) {
      return left == null && right == null;
    }
    if (isOutput) {
      if (left == null || right == null || operator != "XOR") {
        return false;
      }
      if (level == 0) {
        return left!.isInput && right!.isInput;
      }
      if (level == 45) {
        //TODO Verify this
        return true;
      }
      return !left!.isInput &&
          !right!.isInput &&
          !left!.isOutput &&
          !right!.isOutput;
    }

    return true;
  }

  bool get isInput => name[0] == 'x' || name[0] == 'y';
  bool get isOutput => name[0] == 'z';
  bool get isIn3 => left!.level != right!.level;
  bool get isIn2 => left!.isInput && right!.isInput && operator == 'OR';
  int get level {
    if (isInput || isOutput) {
      return int.parse(name.substring(1));
    } else {
      // } else if (left!.level == right!.level) {
      //   return left!.level;
      // } else {
      // var leftLevel = left!.level;
      // var rightLevel = right!.level;
      // if (leftLevel < rightLevel) {
      //   return leftLevel;
      // } else {
      //   return rightLevel;
      // }
      return -1;
    }
  }

  Node(this.name,
      [this.value = -1, this.left, this.right, this.operator, this.parent]);

  @override
  bool operator ==(Object other) {
    return other is Node && name == other.name && value == other.value;
  }

  @override
  int get hashCode => Object.hash(name, value);

  @override
  String toString() {
    return '($name, $value)';
  }
}

class NodeEquality implements Equality<Node> {
  @override
  bool equals(e1, e2) {
    return e1.name == e2.name;
  }

  @override
  int hash(e) {
    throw e.hashCode;
  }

  @override
  bool isValidKey(Object? o) {
    return o is Node;
  }
}

class Day24Solution with Solution {
  Map<String, int> node = {};
  List<String> outputNodeNames = [];
  List<String> gateInput1 = [];
  List<String> gateInput2 = [];
  List<String> gate = [];
  List<String> gateOutputs = [];
  List<Node> circuitTree = [];
  Map<String, Node> nodeMap = {};

  @override
  int get year => 2024;

  @override
  int get day => 24;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    node = {};
    gateInput1 = [];
    gateInput2 = [];
    gate = [];
    gateOutputs = [];
    outputNodeNames = [];

    // Parse lines
    bool parsingInputs = true;
    for (var line in lines) {
      if (line.isEmpty) {
        parsingInputs = false;
        continue;
      }
      if (parsingInputs) {
        var s = line.split(': ');
        var nodeName = s[0];
        var value = int.parse(s[1]);
        node[nodeName] = value;
        nodeMap[nodeName] = Node(nodeName, value);
      } else {
        var s = line.split(' ');
        var left = s[0];
        var right = s[2];
        var operator = s[1];
        var nodeName = s[4];
        node[left] ??= -1;
        node[right] ??= -1;
        node[nodeName] ??= -1;
        gateInput1.add(left);
        gate.add(operator);
        gateInput2.add(right);
        gateOutputs.add(nodeName);
        var leftNode = nodeMap[left] ??= Node(left);
        var rightNode = nodeMap[right] ??= Node(right);
        nodeMap.update(nodeName, (val) {
          val.left = leftNode;
          val.right = rightNode;
          val.operator = operator;
          leftNode.parent = val;
          rightNode.parent = val;
          return val;
        }, ifAbsent: () {
          var newNode = Node(nodeName, -1, leftNode, rightNode, operator);
          leftNode.parent = newNode;
          rightNode.parent = newNode;
          return newNode;
        });
      }
    }

    for (var key in node.keys) {
      if (key[0] == 'z') {
        outputNodeNames.add(key);
      }
    }
    outputNodeNames.sort();

    dataIsValid = true;
  }

  int getOutput() {
    int result = 0;
    for (var output in outputNodeNames.reversed) {
      result = result << 1;
      var nextDigit = node[output] ?? 0;
      result += (nextDigit >= 0 ? nextDigit : 0);
    }
    return result;
  }

  @override
  void part1() {
    bool changed = true;
    while (changed) {
      changed = false;
      for (int i = 0; i < gate.length; i++) {
        var a = gateInput1[i];
        var b = gateInput2[i];
        var c = gateOutputs[i];

        var type = gate[i];

        var lastC = node[c];
        switch (type) {
          case 'AND':
            node[c] = (node[a]! & node[b]!);
          case 'OR':
            node[c] = (node[a]! | node[b]!);
          case 'XOR':
            node[c] = (node[a]! ^ node[b]!);
        }
        if (lastC != node[c]) {
          changed = true;
        }
      }
    }
    answer1 = '${getOutput()}';
  }

  @override
  void part2() {
    List<String> Xn = [];
    List<String> Yn = [];
    List<String> Zn = [];
    List<String> In1 = [];
    List<String> S = [];
    List<String> In2 = [];
    List<String> Cn = [];
    for (var node in nodeMap.values) {
      if (node.operator == 'OR') {
        Cn.add(node.name);
      }
      if (node.name[0] == 'x') {
        Xn.add(node.name);
      }
      if (node.name[0] == 'y') {
        Yn.add(node.name);
      }
      if (node.name[0] == 'z') {
        Zn.add(node.name);
      }
      // if (!node.isInput) {
      //   if (node.left!.isInput &&
      //       node.right!.isInput &&
      //       node.operator == 'XOR') {
      //     In1.add(node!.name);
      //   }
      //   if (node.left!.isInput &&
      //       node.right!.isInput &&
      //       node.operator == 'AND') {
      //     In2.add(node!.name);
      //   }
      // }
      if (node.isInput) {
        // In1.add(node.name);
        // if (!node.isValid()) {
        //   stdout.write('${node.name} is invalid input\n');
        // }
      } else if (node.isOutput) {
        S.add(node.name);
        if (!node.isValid()) {
          stdout.write('${node.name} is invalid output\n');
        }
      } else if (node.operator == 'OR' &&
          node.left?.operator == 'AND' &&
          node.right?.operator == 'AND') {
        if (node.left?.left == null ||
            node.left?.right == null ||
            node.right?.left == null ||
            node.right?.right == null) {
          stdout.write('${node.name} is invalid output\n');
        }
        //   stdout.write('${node.name} is invalid output\n');
        // } else {
        //   stdout.write('${node.name} is invalid output\n');

        // }
      }
    }
    Xn.sort();
    for (var n in Xn) {
      Node node = nodeMap[n]!;
      if (node.parent!.operator != 'XOR' && node.parent!.operator != 'AND') {
        stdout.write(
            'CASE 1: $n is invalid parent operator ${node.parent!.parent!.operator} ${node.parent!.operator} \n');
      }
      if ((node.parent!.operator == 'XOR' &&
              node.parent!.parent!.operator == 'XOR') ||
          (node.parent!.operator == 'XOR' &&
              node.parent!.parent!.operator == 'AND' &&
              node.parent!.parent!.parent!.operator == 'OR')) {
      } else {
        stdout.write(
            'CASE 2: $n is invalid ${node.parent!.name} ${node.parent!.operator} '
            ' ${node.parent!.parent!.name} ${node.parent!.parent!.operator} \n');
      }
      if (node.parent!.operator == 'AND' && node.parent!.operator != 'OR') {
        stdout.write(
            'CASE 3: $n is invalid ${node.parent!.name} ${node.parent!.operator} \n');
      }
    }
    Yn.sort();
    Zn.sort();
    S.sort();
    In1.sort();
    In2.sort();
    Cn.sort();
    {
      // In2 Check
      // if (node.left!.left!.isInput && node.left!.right!.isInput) {
      //   In2.add(node.left!.name);
      // }
      // if (node.right!.left!.isInput && node.right!.right!.isInput) {
      //   In2.add(node.left!.name);
      // }
    }
    List<String> result = [
      'z21',
      'z12',
      'z33',
      'z45',
      'pps',
      'vdc',
      'kcp',
      'nhn'
    ];
    result.sort();
    print(result);
    // not - kcp,nhn,pps,vdc,z12,z21,z33,z45
    answer2 = 'ran 2';
  }
}
