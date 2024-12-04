import 'package:adventofcode2024/data.dart' as puzzle_data;
import 'package:html/parser.dart' as html;

class Day05Solution {
  String puzzleText = '';
  bool dataIsValid = false;
  String answer1 = 'tbd';
  String answer2 = 'tbd';

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
    }

    dataIsValid = true;
  }

  void part1() {
    answer1 = 'ranit';
  }

  void part2() {
    answer2 = 'ran 2';
  }
}
