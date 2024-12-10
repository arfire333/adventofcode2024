import 'package:adventofcode2024/mixins/solution.dart';

class Day03Solution with Solution {
  String puzzle = '';
  List<String> lines = List<String>.empty(growable: true);

  @override
  void parse(String rawData) {
    // Don't forget to clear data
    lines = rawData.split('\n');
    // Parse lines
    dataIsValid = true;
  }

  @override
  void part1() {
    int answer = 0;
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var pattern = RegExp(r'mul\(\d+\,\d+\)');
      var validMatches = pattern.allMatches(line);

      for (var match in validMatches) {
        var current = line.substring(match.start, match.end);
        var sides = current.split(',');
        var left = int.parse(sides[0].split('(')[1]);
        var right = int.parse(sides[1].split(')')[0]);

        answer += left * right;
      }
    }
    answer1 = '$answer';
  }

  @override
  void part2() {
    int answer = 0;
    bool lastWasDo = true;
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var doPattern = RegExp(r'do\(\)');
      var dontPattern = RegExp(r"don\'t\(\)");
      var mulPattern = RegExp(r'mul\(\d+\,\d+\)');
      var validDoMatches = doPattern.allMatches(line);
      var validDontMatches = dontPattern.allMatches(line);
      var validMulMatches = mulPattern.allMatches(line);

      // pair do's with don'ts
      int doIndex = 0;
      int dontIndex = 0;
      List<int> boundries = List<int>.empty(growable: true);
      if (lastWasDo) {
        boundries.add(0);
      }

      while (doIndex < validDoMatches.length &&
          dontIndex < validDontMatches.length) {
        if (lastWasDo) {
          if (validDoMatches.elementAt(doIndex).start <
              validDontMatches.elementAt(dontIndex).start) {
            doIndex++;
            continue;
          }
          boundries.add(validDontMatches.elementAt(dontIndex).start);
          lastWasDo = false;
          dontIndex++;
        } else {
          if (validDontMatches.elementAt(dontIndex).start <
              validDoMatches.elementAt(doIndex).start) {
            dontIndex++;
            continue;
          }
          lastWasDo = true;
          boundries.add(validDoMatches.elementAt(doIndex).start);
          doIndex++;
        }
      }
      if (doIndex < validDoMatches.length) {
        boundries.add(validDoMatches.elementAt(doIndex).start);
        boundries.add(line.length);
        lastWasDo = true;
      }
      if (dontIndex < validDontMatches.length) {
        boundries.add(validDontMatches.elementAt(dontIndex).start);
        boundries.add(line.length);
        lastWasDo = false;
      }

      int currentSum = 0;
      for (var match in validMulMatches) {
        var current = line.substring(match.start, match.end);
        for (var i = 0; i < boundries.length; i += 2) {
          if (match.start >= boundries[i] && match.start < boundries[i + 1]) {
            var sides = current.split(',');
            var left = int.parse(sides[0].split('(')[1]);
            var right = int.parse(sides[1].split(')')[0]);
            currentSum += left * right;
          }
        }
      }
      answer = answer + currentSum;
    }
    answer2 = '$answer';
  }

  @override
  int get day => 3;

  @override
  int get year => 2024;
}
