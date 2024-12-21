import 'dart:io';

import 'package:adventofcode2024/mixins/solution.dart';
import 'package:collection/collection.dart';

class Point {
  int r;
  int c;

  static final Map<Point, Point?> _prev = {};

  Point? get prev => _prev[this];

  set prev(Point? val) => _prev[this] = val;

  static Map<Point, int> _dist = {};

  Point(this.r, this.c);

  static get maxDist => 0x7fffffffffff;

  int get dist => _dist[this] ?? maxDist;

  set dist(int val) => Point._dist[this] = val;

  static void resetDist() {
    _dist = {};
  }

  @override
  bool operator ==(Object other) {
    return other is Point && r == other.r && c == other.c;
  }

  @override
  int get hashCode => Object.hash(r, c);

  @override
  String toString() {
    return '($r, $c):$dist';
  }
}

class Day20Solution with Solution {
  Point start = Point(0, 0);
  Point stop = Point(0, 0);
  List<String> track = [];
  Set<Point> points = {};
  Set<Point> path = {};

  PriorityQueue<Point> q = PriorityQueue((Point a, Point b) {
    return a.dist - b.dist;
  });

  int cheatThreshold = 100;
  int cheatMaxLength = 20;

  @override
  int get year => 2024;

  @override
  int get day => 20;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    points = {};
    track = [];
    path = {};
    q.clear();
    Point.resetDist();
    // Parse lines
    for (int r = 0; r < lines.length; r++) {
      if (lines[r].isEmpty) {
        continue;
      }
      track.add(lines[r]);
      for (var c = 0; c < lines[0].length; c++) {
        if (lines[r][c] == 'S') {
          start = Point(r, c);
        } else if (lines[r][c] == 'E') {
          stop = Point(r, c);
        }
        if (lines[r][c] != '#') {
          points.add(Point(r, c));
        }
      }
    }

    dataIsValid = true;
  }

  static const List<(int, int)> moves =
      //
      [(-1, 0), (0, 1), (1, 0), (0, -1)];

  static const List<(int, int)> cheatDeltas =
      //
      [(-2, 0), (0, 2), (2, 0), (0, -2)];
  static const List<List<(int, int)>> cheatChecks = [
    [(-1, 0)],
    [(0, 1)],
    [(1, 0)],
    [(0, -1)]
  ];

  List<(Point, Point)> getCheatsPart1(Point c) {
    List<(Point, Point)> deltas = [];
    for (int i = 0; i < cheatDeltas.length; i++) {
      for (var (dr, dc) in cheatChecks[i]) {
        if (track[c.r + dr][c.c + dc] == '#') {
          var (adr, adc) = cheatDeltas[i];
          Point next = Point(c.r + adr, c.c + adc);
          if (path.contains(next) && next.dist > (c.dist + cheatThreshold)) {
            deltas.add((c, next));
          }
        }
      }
    }
    return deltas;
  }

  // Map<int, Set<(Point, Point)>> cheatMap = {};
  Map<int, Set<(Point, Point)>> cheatMap = {};

  List<(Point, Point)> getCheats(Point c, [int time = 20]) {
    List<(Point, Point)> deltas = [];
    for (int dr = -time; dr <= time; dr++) {
      for (int dc = -time; dc <= time; dc++) {
        int nr = c.r + dr;
        int nc = c.c + dc;
        if (nr <= 0 ||
            nr >= track.length - 1 ||
            nc <= 0 ||
            nc >= track[0].length - 1) {
          continue;
        }
        if (track[nr][nc] == '#') {
          continue;
        }
        Point next = Point(nr, nc);
        int cheatLength = dr.abs() + dc.abs();
        int timeSaved = next.dist - (c.dist + cheatLength);

        if (cheatLength > time) {
          continue;
        }
        if (!path.contains(next)) {
          continue;
        }
        if (timeSaved < cheatThreshold) {
          continue;
        }
        deltas.add((c, next));
        if (!cheatMap.containsKey(timeSaved)) {
          cheatMap[timeSaved] = {};
        }
        cheatMap[timeSaved]!.add((c, next));
      }
    }
    return deltas;
  }

  void populateQ() {
    for (var p in points) {
      q.add(p);
    }
    Point.resetDist();
    start.dist = 0;
  }

  void dikstra() {
    q.add(start);
    while (q.isNotEmpty) {
      var curr = q.first;
      q.removeFirst();
      // stdout.write('$curr -');
      for (var (dr, dc) in moves) {
        Point next = Point(curr.r + dr, curr.c + dc);
        if (points.contains(next) && next.dist > curr.dist + 1) {
          next.prev = curr;
          next.dist = curr.dist + 1;
          q.remove(next);
          q.add(next);
        }
      }
    }
  }

  void populatePath() {
    Point? curr = stop;
    while (curr != null) {
      path.add(curr);
      curr = curr.prev;
    }
  }

  @override
  void part1() {
    populateQ();
    dikstra();
    populatePath();
    List<(Point, Point)> cheats = [];
    for (var p in path) {
      cheats.addAll(getCheatsPart1(p));
    }
    answer1 = '${cheats.length}';
  }

  @override
  void part2() {
    populateQ();
    dikstra();
    populatePath();
    List<(Point, Point)> cheats = [];
    for (var p in path) {
      cheats.addAll(getCheats(p, cheatMaxLength));
    }
    for (var entry in cheatMap.entries.sorted((a, b) {
      return a.key - b.key;
    })) {
      stdout.write(
          '- There are ${entry.value.length} cheats that save ${entry.key} picoseconds.\n');
    }

    answer2 = '${cheats.length}';
  }
}
