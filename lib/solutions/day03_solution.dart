import 'package:adventofcode2024/data.dart' as puzzle_data;

class Day03Solution {
  bool dataIsValid = false;
  String answer1 = 'tbd';
  String answer2 = 'tbd';

  Future<void> fetchData(int year, int day) async {
    var rawData = await puzzle_data.fetchPuzzleData(year, day);

    if (rawData == null) {
      answer1 = 'Error getting data.';
      answer2 = 'Error getting data.';
      return;
    }

    parse(rawData);
  }

  void parse(String rawData) {
    dataIsValid = true;
    // Don't forget to clear data
    var lines = rawData.split('\n');
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
    }
  }

  void part1() {
    answer1 = 'ranit';
  }

  void part2() {
    answer2 = 'ran 2';
  }
}
