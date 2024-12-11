import 'package:adventofcode2024/mixins/solution.dart';

class Day10Solution with Solution {
  List<List<int>> map = [];
  Set<(int, int)> trailheads = {};

  Day10Solution() {
    init();
  }

  @override
  int get year => 2024;

  @override
  int get day => 10;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    map.clear();
    trailheads.clear();

    // Parse lines
    int row = 0;
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      List<int> next = [];
      for (int col = 0; col < line.length; col++) {
        next.add(int.parse(line[col]));
        if (line[col] == '0') {
          trailheads.add((row, col));
        }
      }
      map.add(next);
      row++;
    }

    dataIsValid = true;
  }

  final List<(int, int)> directions = [(1, 0), (-1, 0), (0, 1), (0, -1)];

  int search(Set<(int, int)> visited, int cr, int cc, int targetAlt,
      Set<(int, int)> destinations) {
    var alt = map[cr][cc];
    if (alt != targetAlt) {
      return 0;
    }
    if (alt == 9) {
      destinations.add((cr, cc));
      return 1;
    }
    var result = 0;

    for (int d = 0; d < directions.length; d++) {
      var nr = cr + directions[d].$1;
      var nc = cc + directions[d].$2;
      if (nr < 0 || nr >= map.length || nc < 0 || nc >= map[0].length) {
        continue;
      }

      if (!visited.contains((nr, nc))) {
        var newVisited = Set<(int, int)>.from(visited);
        newVisited.add((nr, nc));
        result += search(newVisited, nr, nc, alt + 1, destinations);
      }
    }

    return result;
  }

  @override
  void part1() {
    int count = 0;
    for (var (r, c) in trailheads) {
      Set<(int, int)> destinations = {};
      Set<(int, int)> visited = {}; // direction, row, col
      search(visited, r, c, 0, destinations);
      count += destinations.length;
    }

    answer1 = '$count';
  }

  @override
  void part2() {
    int count2 = 0;
    for (var (r, c) in trailheads) {
      Set<(int, int)> path = {};
      Set<(int, int)> visited = {}; // direction, row, col
      count2 += search(visited, r, c, 0, path);
    }

    answer2 = '$count2';
  }
}
