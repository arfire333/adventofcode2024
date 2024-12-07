import 'dart:math';

import 'package:adventofcode2024/data.dart' as puzzle_data;
import 'package:html/parser.dart' as html;

class Day07Solution {
  String puzzleText = '';
  bool dataIsValid = false;
  String answer1 = 'tbd';
  String answer2 = 'tbd';
  List<int> testValues = [];
  List<List<int>> testInputs = [];

  Future<void> fetchData(int year, int day) async {
    var rawData = await puzzle_data.fetchPuzzleData(year, day);
    var rawPuzzle = await puzzle_data.fetchPuzzle(year, day) ?? '';

    puzzleText = html.parse(rawPuzzle).body?.querySelector('main')?.text ?? '';

    if (rawData == null) {
      answer1 = 'Error getting data.';
      answer2 = 'Error getting data.';
      return;
    }
    parse(rawData);
  }

  void parse(String rawData) {
    // Don't forget to clear data
    var lines = rawData.split('\n');
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var s = line.split(':');
      testValues.add(int.parse(s[0]));
      var v = s[1].split(' ');
      List<int> inputs = [];
      for (var val in v) {
        if (val.isEmpty) {
          continue;
        }
        inputs.add(int.parse(val));
      }
      testInputs.add(inputs);
    }

    dataIsValid = true;
  }

  num concat(int l, int r) {
    int rc = r;
    int sc = 0;
    if (r == 0) {
      return l * 10;
    }
    while (rc > 0) {
      sc++;
      rc = rc ~/ 10;
    }

    var power = pow(10, sc);
    return l * power + r;
  }

  bool operatorCheck(int value, List<int> inputs, int ci, int answer,
      {bool extraOp = false}) {
    if (ci >= inputs.length) {
      return answer == value;
    }
    bool result = false;
    result |= operatorCheck(value, inputs, ci + 1, answer + inputs[ci],
        extraOp: extraOp);
    result |= operatorCheck(value, inputs, ci + 1, answer * inputs[ci],
        extraOp: extraOp);
    if (extraOp) {
      var val = concat(answer, inputs[ci]);
      result |=
          operatorCheck(value, inputs, ci + 1, val.toInt(), extraOp: extraOp);
    }

    return result;
  }

  void part1() {
    int sum = 0;
    for (int i = 0; i < testValues.length; i++) {
      if (operatorCheck(testValues[i], testInputs[i], 0, 0)) {
        sum += testValues[i];
      }
    }
    answer1 = '$sum';
  }

  void part2() {
    int sum = 0;
    for (int i = 0; i < testValues.length; i++) {
      if (operatorCheck(testValues[i], testInputs[i], 0, 0, extraOp: true)) {
        sum += testValues[i];
      }
    }
    answer2 = '$sum';
  }
}
