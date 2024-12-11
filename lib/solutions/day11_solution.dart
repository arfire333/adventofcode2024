import 'package:adventofcode2024/mixins/solution.dart';

class Graph {
  List<Node> nodes = [];
}

class Node {
  String value = '';
  Node? left;
  Node? right;

  Node(this.value);

  bool split() {
    return left == null && right == null;
  }

  @override
  bool operator ==(Object other) {
    return this == other && other is Node && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return value;
  }
}

class Day11Solution with Solution {
  late Graph stoneLine;
  @override
  int get year => 2024;

  @override
  int get day => 11;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    stoneLine = Graph();
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var stones = line.split(' ');
      for (String stone in stones) {
        stoneLine.nodes.add(Node(stone));
      }
    }

    dataIsValid = true;
  }

  void processStone(Node stone) {
    if (stone.value == '0') {
      stone.value = '1';
    } else if (stone.value.length % 2 == 0) {
      int middle = stone.value.length ~/ 2;
      int leftNum = int.parse(stone.value.substring(0, middle));
      stone.left = Node('$leftNum');
      int rightNum = int.parse(stone.value.substring(middle));
      stone.right = Node('$rightNum');
    } else {
      int val = int.parse(stone.value) * 2024;
      stone.value = '$val';
    }
  }

  void blink() {
    List<Node> next = [];
    for (var stone in stoneLine.nodes) {
      processStone(stone);
      if (stone.left != null && stone.right != null) {
        next.add(Node(stone.left!.value));
        next.add(Node(stone.right!.value));
      } else {
        next.add(stone);
      }
    }
    stoneLine.nodes = next;
  }

  @override
  void part1() {
    for (int i = 0; i < 25; i++) {
      blink();
    }

    answer1 = '${stoneLine.nodes.length}';
  }

  (String, String) processStone2(String stone) {
    if (stone == '0') {
      return ('1', '');
    } else if (stone.length % 2 == 0) {
      int middle = stone.length ~/ 2;
      int leftNum = int.parse(stone.substring(0, middle));
      int rightNum = int.parse(stone.substring(middle));
      return ('$leftNum', '$rightNum');
    }
    int val = int.parse(stone) * 2024;
    return ('$val', '');
  }

  BigInt blink2(int blink, String stone, Map<(int, String), BigInt> dp) {
    if (dp.containsKey((blink, stone))) {
      var val = dp[(blink, stone)] ?? BigInt.from(0);
      return val;
    }
    if (blink == 0) {
      return BigInt.from(1);
    }
    var (left, right) = processStone2(stone);
    BigInt result = BigInt.from(0);
    if (left.isNotEmpty) {
      result += blink2(blink - 1, left, dp);
    }
    if (right.isNotEmpty) {
      result += blink2(blink - 1, right, dp);
    }
    dp[(blink, stone)] = result;
    return result;
  }

  @override
  void part2() {
    BigInt count = BigInt.from(0);
    Map<(int, String), BigInt> dp = {};
    for (var stone in stoneLine.nodes) {
      count += blink2(50, stone.value, dp);
    }

    answer2 = '$count';
  }
}
