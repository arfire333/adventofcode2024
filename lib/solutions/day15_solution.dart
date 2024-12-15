import 'package:adventofcode2024/mixins/solution.dart';

class Day15Solution with Solution {
  @override
  int get year => 2024;

  @override
  int get day => 15;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
    }

    dataIsValid = true;
  }

  @override
  void part1() {
    answer1 = 'ranit';
  }

  @override
  void part2() {
    answer2 = 'ran 2';
  }
}
