import 'dart:math';

import 'package:adventofcode2024/mixins/solution.dart';
import 'package:collection/collection.dart';

class Point {
  int r;
  int c;
  static Map<Point, int> _dist = {};

  Point(this.r, this.c);

  int get dist => _dist[this] ?? 0x7fffffffffff;

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
}

class Day18Solution with Solution {
  int numRows = 71;
  int numCols = 71;

  Set<Point> visited = {};
  Point start = Point(0, 0);
  Point stop = Point(0, 0);
  List<Point> bytes = [];
  Set<Point> bytesFallen = {};
  PriorityQueue<Point> q = PriorityQueue((a, b) {
    return a.dist - b.dist;
  });
  int tic = 0;
  int part1tics = 1024;
  int startRow = 0;
  int startCol = 0;
  int stopRow = 0;
  int stopCol = 0;

  @override
  int get year => 2024;

  @override
  int get day => 18;

  @override
  void parse(String rawData, {int rows = 71, int cols = 71}) {
    numRows = rows;
    numCols = cols;
    stopRow = numRows - 1;
    stopCol = numCols - 1;
    stop = Point(stopRow, stopCol);
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var vals = line.split(',').map((element) => int.parse(element)).toList();
      bytes.add(Point(vals[0], vals[1]));
    }

    dataIsValid = true;
  }

  void reset() {
    tic = 0;
    bytesFallen = {};
    Point.resetDist();
    Point(0, 0).dist = 0;
  }

  void update() {
    bytesFallen.add(bytes[tic]);
    tic++;
  }

  bool isValidPoint(Point p) {
    if (p.r < 0 || p.r >= numRows || p.c < 0 || p.c >= numCols) {
      return false;
    }
    if (bytesFallen.contains(p)) {
      return false;
    }
    return true;
  }

  static const List<(int, int)> moves = [(-1, 0), (1, 0), (0, -1), (0, 1)];

  List<Point> nextPointList(Point p) {
    List<Point> l = [];
    for (var (dr, dc) in moves) {
      var np = Point(p.r + dr, p.c + dc);
      if (isValidPoint(np)) {
        l.add(np);
      }
    }
    return l;
  }

  @override
  void part1() {
    reset();
    for (int i = 0; i < part1tics; i++) {
      update();
    }
    Map<Point, Point> prev = search();
    Point? curr = stop;
    int count = 0;
    while (curr != null) {
      curr = prev[curr];
      count++;
    }
    count--;
    answer1 = '$count';
  }

  Map<Point, Point> search() {
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        var p = Point(r, c);
        if (bytes.contains(p)) {
          continue;
        }
        q.add(p);
      }
    }
    Map<Point, Point> prev = {};
    while (q.isNotEmpty) {
      var curr = q.first;
      q.removeFirst();
      for (var next in nextPointList(curr)) {
        var alt = max(curr.dist + 1, curr.dist);
        if (alt < next.dist) {
          next.dist = alt;
          q.remove(next);
          q.add(next);
          prev[next] = curr;
        }
      }
    }
    return prev;
  }

  @override
  void part2() {
    reset();
    int i = 0;
    for (i = 0; i < part1tics; i++) {
      update();
    }
    for (i = i; i < bytes.length; i++) {
      update();
      Point.resetDist();
      Point(0, 0).dist = 0;
      search();
      if (stop.dist >= 0x7fffffffffff) {
        break;
      }
      answer2 = '$i';
    }
    int r = bytes[i].r;
    int c = bytes[i].c;
    answer2 = '$r,$c';
  }
}
