import 'package:adventofcode2024/mixins/solution.dart';

class Day08Solution with Solution {
  List<List<String>> puzzle = [];
  List<List<int>> antinodes = [];
  Map<String, Set<(int r, int c)>> antennas = {};

  @override
  void parse(String rawData) {
    // Don't forget to clear data
    var lines = rawData.split('\n');
    puzzle.clear();
    antinodes.clear();
    antennas.clear();
    // Parse lines
    int row = 0;
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }

      List<String> l = [];
      for (int col = 0; col < line.length; col++) {
        l.add(line[col]);
        if (line[col] != '.') {
          String key = line[col];
          if (antennas.containsKey(key)) {
            antennas[key]?.add((row, col));
          } else {
            var e = (row, col);
            Set<(int, int)> s = {e};
            antennas[key] = (s);
          }
        }
      }
      antinodes.add(List<int>.filled(l.length, 0));
      puzzle.add(l);
      row++;
    }

    dataIsValid = true;
  }

  bool inBounds((int, int) p) {
    var r = p.$1;
    var c = p.$2;
    if (r < 0 || r >= puzzle.length || c < 0 || c >= puzzle[0].length) {
      return false;
    }

    return true;
  }

  (int, int) antinode((int, int) l, (int, int) r) {
    var dr = r.$1 - l.$1;
    var dc = r.$2 - l.$2;

    return (r.$1 + dr, r.$2 + dc);
  }

  void addValidAntinodes((int, int) l, (int, int) r) {
    var dr = r.$1 - l.$1;
    var dc = r.$2 - l.$2;

    int row = l.$1 + dr;
    int col = l.$2 + dc;

    while (inBounds((row, col))) {
      antinodes[row][col]++;
      row = row + dr;
      col = col + dc;
    }
  }

  @override
  void part1() {
    antennas.forEach((freq, loc) {
      // Each pair can have two antinodes
      for (var ant1 in loc) {
        for (var ant2 in loc) {
          if (ant1 == ant2) {
            continue;
          }
          var pantinode = antinode(ant1, ant2);
          if (inBounds(pantinode)) {
            antinodes[pantinode.$1][pantinode.$2]++;
          }
        }
      }
    });
    int answer = 0;
    for (var r in antinodes) {
      for (var c in r) {
        if (c > 0) {
          answer++;
        }
      }
    }

    answer1 = '$answer';
  }

  @override
  void part2() {
    antennas.forEach((freq, loc) {
      // Each pair can have two antinodes
      for (var ant1 in loc) {
        for (var ant2 in loc) {
          if (ant1 == ant2) {
            continue;
          }
          addValidAntinodes(ant1, ant2);
        }
      }
    });
    int answer = 0;
    for (var r in antinodes) {
      for (var c in r) {
        if (c > 0) {
          answer++;
        }
      }
    }

    answer2 = '$answer';
  }

  @override
  int get day => 8;

  @override
  int get year => 2024;
}
