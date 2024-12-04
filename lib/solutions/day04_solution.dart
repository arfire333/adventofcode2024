import 'dart:ffi';

import 'package:adventofcode2024/data.dart' as puzzle_data;
import 'package:html/parser.dart' as html;

class Day04Solution {
  List<String> puzzle = List<String>.empty(growable: true);
  String puzzleText = '';

  bool dataIsValid = false;
  String answer1 = 'tbd';
  String answer2 = 'tbd';
  List<String> lines = List<String>.empty(growable: true);

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
    puzzle = rawData.split('\n');
    // Parse lines
    for (int i = 0; i < puzzle.length; i++) {
      if (puzzle[i].isEmpty) {
        puzzle.removeAt(i);
      }
    }
    dataIsValid = true;
  }

  int part1Check(int row, int col, int dr, int dc) {
    String searchString = "XMAS";
    // dr/dc say which direction to check
    int rOffset = 0;
    int cOffset = 0;
    for (int i = 0; i < searchString.length; i++) {
      int rPos = row + rOffset;
      int cPos = col + cOffset;
      // Out of bounds
      if (rPos < 0 ||
          rPos >= puzzle.length ||
          cPos < 0 ||
          cPos >= puzzle[0].length) {
        return 0;
      }
      if (puzzle[rPos][cPos] != searchString[i]) {
        return 0;
      }
      rOffset += dr;
      cOffset += dc;
    }

    return 1;
  }

  int part1CheckAll(int row, int col) {
    int count = 0;
    List<int> deltaRows = [-1, 0, 1];
    List<int> deltaCols = [-1, 0, 1];
    for (int dr in deltaRows) {
      for (int dc in deltaCols) {
        if (dr == 0 && dc == 0) {
          continue;
        }
        count += part1Check(row, col, dr, dc);
      }
    }
    return count;
  }

  void part1() {
    int answer = 0;

    for (int row = 0; row < puzzle.length; row++) {
      for (int col = 0; col < puzzle[0].length; col++) {
        answer += part1CheckAll(row, col);
      }
    }

    answer1 = '$answer';
  }

  bool validSpot(int row, int col) {
    if (row < 0 || row >= puzzle.length || col < 0 || col >= puzzle[0].length) {
      return false;
    }
    return true;
  }

  int part2Check(int row, int col) {
    var cl = puzzle[row][col];
    if (cl != 'A') {
      return 0;
    }
    // ==============
    //   M   ||    S
    // ==============
    // -1,-1 ->  1, 1
    // -1, 1 ->  1,-1
    //  1,-1 -> -1, 1
    //  1, 1 -> -1,-1
    // ==============
    int count = 0;
    for (var dr in [-1, 1]) {
      for (var dc in [-1, 1]) {
        var rm = row + dr;
        var rs = row - dr;
        var cm = col + dc;
        var cs = col - dc;
        if (!validSpot(rm, cm) || !validSpot(rs, cs)) {
          return 0;
        }
        cl = puzzle[rm][cm];
        var ol = puzzle[rs][cs];
        if (cl == 'M' && ol == 'S') {
          count++;
        }
      }
    }

    return (count == 2 ? 1 : 0);
  }

  void part2() {
    int answer = 0;
    for (int row = 0; row < puzzle.length; row++) {
      for (int col = 0; col < puzzle[0].length; col++) {
        answer += part2Check(row, col);
      }
    }
    answer2 = '$answer';
  }
}
