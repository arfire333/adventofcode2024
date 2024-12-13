import 'package:adventofcode2024/mixins/solution.dart';

class Region {
  Region? parent;
  String id = '';
  int r = 0;
  int c = 0;
  int a = -1;
  int p = -1;
  Region(this.id, this.r, this.c);
  int price() {
    return a * p;
  }
}

class Day12Solution with Solution {
  List<int> groups = [];
  List<Region> regions = [];
  List<String> map = [];
  List<List<Map<int, int>>> corners = [];
  int biggestGroup = 0;

  // Find the parent index of the region
  int find(int i) {
    List<int> paths = [];

    while (groups[i] > 0) {
      paths.add(i);
      i = groups[i];
    }

    for (var path in paths) {
      groups[path] = i;
    }
    return i;
  }

  void union(int i, int k) {
    int iParent = find(i);
    int kParent = find(k);

    // See if they are already in the same region
    if (iParent == kParent) {
      return;
    }

    int iSize = groups[iParent];
    int kSize = groups[kParent];

    if (iSize <= kSize) {
      groups[kParent] += iSize;
      groups[iParent] = kParent;
      if (groups[biggestGroup] > groups[kParent]) {
        biggestGroup = kParent;
      }
    } else {
      groups[iParent] += kSize;
      groups[kParent] = iParent;
      if (groups[biggestGroup] > groups[iParent]) {
        biggestGroup = iParent;
      }
    }
  }

  @override
  int get year => 2024;

  @override
  int get day => 12;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    int r = 0;
    regions = [Region('', -1, -1)];
    groups = [0];
    map = [];
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      map.add(line);
      for (int c = 0; c < line.length; c++) {
        regions.add(Region(line[c], r, c));
        groups.add(-1);
      }
      r++;
    }

    dataIsValid = true;
  }

  static const deltas = [(-1, 0), (1, 0), (0, 1), (0, -1)];

  bool isAdjacent(Region a, Region b) {
    for (var (rd, cd) in deltas) {
      if (a.r + rd == b.r && a.c + cd == b.c) {
        return true;
      }
    }

    return false;
  }

  int perimeterCount(Region a) {
    int count = 0;
    for (var (rd, cd) in deltas) {
      var r = a.r + rd;
      var c = a.c + cd;
      if (r < 0 || r >= map.length || c < 0 || c >= map[0].length) {
        count++;
        continue;
      } else if (map[r][c] == a.id) {
        continue;
      }
      count++;
    }
    return count;
  }

  int numRegions() {
    int count = 0;
    for (int i = 0; i < groups.length; i++) {
      if (groups[i] < 0) {
        count++;
      }
    }

    return count;
  }

  void segment() {
    for (int i = 0; i < regions.length - 1; i++) {
      for (int j = i + 1; j < regions.length; j++) {
        if (regions[i].id == regions[j].id &&
            isAdjacent(regions[i], regions[j])) {
          union(i, j);
        }
      }
    }
  }

  @override
  void part1() {
    segment();
    List<int> perimeter = [];
    List<int> area = [];
    List<int> parents = [];
    Map<int, int> parent2region = {};
    List<String> type = [];

    for (int i = 0; i < groups.length; i++) {
      if (groups[i] < 0) {
        perimeter.add(0);
        area.add(-groups[i]);
        parent2region[i] = parents.length;
        parents.add(i);
        type.add(regions[i].id);
      }
    }

    for (int i = 1; i < groups.length; i++) {
      int p = perimeterCount(regions[i]);
      int parent = find(i);
      int region = parent2region[parent]!;
      perimeter[region] += p;
    }

    int cost = 0;
    for (int i = 0; i < perimeter.length; i++) {
      cost += perimeter[i] * area[i];
    }

    answer1 = '$cost';
  }

  int sideCount(Region a) {
    int count = 0;
    for (var (rd, cd) in deltas) {
      var r = a.r + rd;
      var c = a.c + cd;
      if (r < 0 || r >= map.length || c < 0 || c >= map[0].length) {
        count++;
        continue;
      } else if (map[r][c] == a.id) {
        continue;
      }
      count++;
    }
    return count;
  }

  @override
  void part2() {
    segment();
    List<int> sides = [];
    List<int> area = [];
    List<int> parents = [];
    Map<int, int> parent2region = {};
    List<String> type = [];

    for (int i = 0; i < groups.length; i++) {
      if (groups[i] < 0) {
        sides.add(0);
        area.add(-groups[i]);
        parent2region[i] = parents.length;
        parents.add(i);
        type.add(regions[i].id);
      }
    }

    for (int r = 0; r < map.length * 2 + 1; r++) {
      corners.add([]);
      for (int c = 0; c < map[0].length * 2 + 1; c++) {
        corners[r].add({});
        for (int p = 0; p < parents.length; p++) {
          corners[r][c];
        }
      }
    }
    const cornDelts = [(-1, -1, 1), (-1, 1, -1), (1, 1, 1), (1, -1, -1)];
    for (int i = 1; i < regions.length; i++) {
      Region cr = regions[i];
      int parent = find(i);
      int region = parent2region[parent]!;
      for (var (dr, dc, count) in cornDelts) {
        var ri = cr.r * 2 + 1 + dr;
        var ci = cr.c * 2 + 1 + dc;
        corners[ri][ci][region] = (corners[ri][ci][region] ?? 0) + count;
      }
    }
    for (int i = 0; i < sides.length; i++) {
      for (int r = 0; r < corners.length; r++) {
        for (int c = 0; c < corners[0].length; c++) {
          if (corners[r][c].containsKey(i)) {
            int val = corners[r][c][i]!;
            sides[i] += (val > 0 ? val : -val);
          }
        }
      }
    }

    int cost = 0;
    for (int i = 0; i < sides.length; i++) {
      cost += sides[i] * area[i];
    }
    answer2 = '$cost';
  }
}
