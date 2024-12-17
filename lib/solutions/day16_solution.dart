import 'dart:collection';
import 'dart:io';

import 'package:adventofcode2024/mixins/solution.dart';
import 'package:collection/collection.dart';

class Pos {
  int r;
  int c;
  String dir;

  static Map<Pos, int> dist = {};

  @override
  int get hashCode => r * 10000000 + c * 1000 + dir.hashCode;

  Pos(this.r, this.c, this.dir);

  @override
  bool operator ==(Object other) {
    Pos o = other as Pos;
    return r == o.r && c == o.c && dir == o.dir;
  }

  @override
  String toString() {
    return 'Pos($r, $c, $dir)';
  }
}

class Day16Solution with Solution {
  Pos start = Pos(0, 0, 'E');
  List<Pos> stop = [];
  int stopIndex = 0;
  Map<Pos, Set<Pos>> prev = {};
  Map<Pos, List<(Pos, int)>> graph = {};
  List<List<String>> maze = [];
  HeapPriorityQueue<Pos> q = HeapPriorityQueue((a, b) {
    return Pos.dist[a]! - Pos.dist[b]!;
  });
  @override
  int get year => 2024;

  @override
  int get day => 16;

  void resetDistance() {
    for (var entry in graph.entries) {
      var key = entry.key;
      Pos.dist[key] = 0x7fffffffffffffff;
      prev[key] = {};
    }
    Pos.dist[start] = 0;
  }

  static const Map<String, (int, int)> toPrev = {
    'N': (1, 0),
    'E': (0, -1),
    'S': (-1, 0),
    'W': (0, 1),
  };
  static const Map<String, (int, int)> toNext = {
    'N': (-1, 0),
    'E': (0, 1),
    'S': (1, 0),
    'W': (0, -1),
  };
  static const Map<String, List<String>> rotateDirections = {
    'N': ['E', 'W'],
    'E': ['N', 'S'],
    'S': ['E', 'W'],
    'W': ['N', 'S'],
  };
  static const List<String> directionsIn = ['N', 'E', 'S', 'W'];

  void addGraph(int r, int c) {
    for (var dirIn in directionsIn) {
      var pIn = Pos(r, c, dirIn);
      if (!graph.containsKey(pIn)) {
        graph[pIn] = [];
      }
      for (var dirOut in rotateDirections[dirIn]!) {
        var pOut = Pos(r, c, dirOut);
        graph[pIn]!.add((pOut, 1000));
      }
      int nr = r + toNext[dirIn]!.$1;
      int nc = c + toNext[dirIn]!.$2;
      if (maze[nr][nc] != '#') {
        graph[pIn]!.add((Pos(nr, nc, dirIn), 1));
      }
    }
  }

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    maze = [];
    graph = {};
    // Parse lines
    for (int r = 0; r < lines.length; r++) {
      if (lines[r].isEmpty) {
        continue;
      }
      maze.add(lines[r].split(''));
      List<(int, String)> lineScores = [];
      for (int c = 0; c < lines[0].length; c++) {
        lineScores.add((0x7fffffffffffffff, 'E'));
        if (lines[r][c] == 'S') {
          start = Pos(r, c, 'E');
        } else if (lines[r][c] == 'E') {
          stop.add(Pos(r, c, 'N'));
          stop.add(Pos(r, c, 'E'));
          stop.add(Pos(r, c, 'W'));
          stop.add(Pos(r, c, 'S'));
        }
      }
    }
    for (int r = 1; r < maze.length - 1; r++) {
      for (int c = 1; c < maze[0].length - 1; c++) {
        addGraph(r, c);
      }
    }

    dataIsValid = true;
  }

  void populateQ() {
    for (var entry in Pos.dist.entries) {
      q.add(entry.key);
    }
  }

  @override
  void part1() {
    resetDistance();
    populateQ();
    while (q.isNotEmpty) {
      var curr = q.first;
      q.removeFirst();
      for (var entry in graph[curr]!) {
        var next = entry.$1;
        int ncost = entry.$2;
        int alt = Pos.dist[curr]! + ncost;
        if (!Pos.dist.containsKey(next)) {
          continue;
        }
        if (alt > 0 && alt < Pos.dist[next]!) {
          q.remove(next);
          Pos.dist[next] = alt;
          q.add(next);
          prev[next] = {curr};
        } else if (alt == Pos.dist[next]) {
          prev[next]!.add(curr);
        }
      }
    }
    int min = 0x7fffffffffffffff;
    for (int i = 0; i < stop.length; i++) {
      var entry = stop[i];
      if (Pos.dist[entry]! < min) {
        min = Pos.dist[entry]!;
        stopIndex = i;
      }
    }

    answer1 = '$min';
  }

  @override
  void part2() {
    Pos? curr = stop[stopIndex];
    stdout.write('$curr \n');
    Set<(int, int)> unique = {(curr.r, curr.c)};
    Queue<Pos> vq = Queue.from([curr]);
    while (vq.isNotEmpty) {
      var cur = vq.first;
      vq.removeFirst();
      for (var next in prev[cur]!) {
        unique.add((next.r, next.c));
        vq.add(next);
      }
    }
    answer2 = '${unique.length}';
  }
}
