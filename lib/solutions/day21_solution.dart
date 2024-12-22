import 'dart:collection';
import 'dart:io';

import 'package:adventofcode2024/mixins/solution.dart';
import 'package:flutter/material.dart';

class Day21Solution with Solution {
  Map<(String, String), Set<String>> numPadMap = {};
  Map<(String, String), Set<String>> dirPadMap = {};

  List<String> combos = [];
  @override
  int get year => 2024;

  @override
  int get day => 21;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      combos.add(line);
    }

    dataIsValid = true;
  }

  final List<String> numPad = [
    //
    "#####",
    "#789#",
    "#456#",
    "#123#",
    "##0A#",
    "#####"
  ];
  final Map<String, (int, int)> numPadButton2Location = {
    '0': (4, 2),
    'A': (4, 3),
    '1': (3, 1),
    '2': (3, 2),
    '3': (3, 3),
    '4': (2, 1),
    '5': (2, 2),
    '6': (2, 3),
    '7': (1, 1),
    '8': (1, 2),
    '9': (1, 3),
  };

  final List<String> dirPad = [
    //
    "#####",
    "##^A#",
    "#<v>#",
    "#####"
  ];
  final Map<String, (int, int)> dirPadButton2Location = {
    '^': (1, 2),
    'A': (1, 3),
    '<': (2, 1),
    'v': (2, 2),
    '>': (2, 3),
  };

  List<(int, int, String)> deltas = [
    //
    (-1, 0, '^'),
    (0, 1, '>'),
    (1, 0, 'v'),
    (0, -1, '<')
  ];

  void getNumPadList(
    String goal,
    String last,
    Set<(int, int)> visited,
    int r,
    int c,
    String path,
    Set<String> paths,
  ) {
    if (numPad[r][c] == goal) {
      if (paths.isEmpty) {
        paths.add('${path}A');
        return;
      }
      if (path.length < paths.first.length - 1) {
        paths.clear();
      } else if (path.length > paths.first.length - 1) {
        return;
      }
      paths.add('${path}A');
      return;
    }
    visited.add((r, c));

    Set<(int, int)> nextVisited = Set<(int, int)>.from(visited);
    for (int i = 0; i < deltas.length; i++) {
      var (dr, dc, char) = deltas[i];
      int nr = r + dr;
      int nc = c + dc;
      if (numPad[nr][nc] == '#') {
        continue;
      }
      if (visited.contains((nr, nc))) {
        continue;
      }
      getNumPadList(goal, char, nextVisited, nr, nc, path + char, paths);
    }
  }

  void buildNumberPad() {
    String keys = 'A0123456789';
    for (var fromKey in keys.characters) {
      for (var toKey in keys.characters) {
        var (nr, nc) = numPadButton2Location[fromKey]!;
        Set<String> paths = {};
        getNumPadList(toKey, '', {}, nr, nc, '', paths);
        numPadMap[(fromKey, toKey)] = (paths);
      }
    }
    stdout.write('$numPadMap \n');
  }

  void getDirPadList(
    String goal,
    String last,
    Set<(int, int)> visited,
    int r,
    int c,
    String path,
    Set<String> paths,
  ) {
    if (dirPad[r][c] == goal) {
      if (paths.isEmpty) {
        paths.add('${path}A');
        return;
      }
      if (path.length < paths.first.length - 1) {
        paths.clear();
      } else if (path.length > paths.first.length - 1) {
        return;
      }
      paths.add('${path}A');
      return;
    }
    visited.add((r, c));

    Set<(int, int)> nextVisited = Set<(int, int)>.from(visited);
    for (int i = 0; i < deltas.length; i++) {
      var (dr, dc, char) = deltas[i];
      int nr = r + dr;
      int nc = c + dc;
      if (dirPad[nr][nc] == '#') {
        continue;
      }
      if (visited.contains((nr, nc))) {
        continue;
      }
      getDirPadList(goal, char, nextVisited, nr, nc, path + char, paths);
    }
  }

  void buildDirPad() {
    String keys = 'A<>^v';
    for (var fromKey in keys.characters) {
      for (var toKey in keys.characters) {
        var (nr, nc) = dirPadButton2Location[fromKey]!;
        Set<String> paths = {};
        getDirPadList(toKey, '', {}, nr, nc, '', paths);
        dirPadMap[(fromKey, toKey)] = (paths);
      }
    }
    stdout.write('$dirPadMap \n');
  }

  int shortest = 0x7ffffffffffff;
  int topDepth = 3;

  Set<String> shortestEntry(Set<String> code, int depth) {
    String last = 'A';
    if (depth == 0) {
      return code;
    }
    int smallestLength = 0x7fffffffffff;
    String smallest = '';
    for (var current in code) {
      String combined = '';
      for (var letter in current.characters) {
        late Set<String>? nextSet;
        if (depth == topDepth) {
          print('**** NEXT DIGIT: $letter');
          nextSet = numPadMap[(last, letter)];
        } else {
          nextSet = dirPadMap[(last, letter)];
        }
        if (depth != 1) {
          print('$depth : $code : $last-$letter :  $nextSet ');
        }
        int minLength = 0x7fffffffffffff;
        String minOne = '';
        for (var short in shortestEntry(nextSet!, depth - 1)) {
          if (short.length < minLength) {
            minOne = short;
            minLength = short.length;
          }
        }
        combined = combined + minOne;
        last = letter;
      }
      if (depth != 1) {
        print('$depth : NEXT: $combined ');
      }
      if (combined.length < smallestLength) {
        smallest = combined;
        smallestLength = smallest.length;
      }
      last = 'A';
    }
    if (depth != 1) {
      print('$depth : SMALLEST: $smallest');
    }
    return {smallest};
  }

  @override
  void part1() {
    buildNumberPad();
    buildDirPad();
    int sum = 0;
    topDepth = 3;
    // for (var code in combos) {
    var code = '379A';
    var last = 'A';
    String completeCode = '';
    for (var letter in code.characters) {
      completeCode = completeCode + numPadMap[(last, letter)]!.first;
      last = letter;
    }
    var numericCode = int.parse(code.substring(0, 3));
    Set<String> entryOptions = shortestEntry({completeCode}, topDepth - 1);

    print(' $numericCode * ${entryOptions.first.length}');
    sum += numericCode * entryOptions.first.length;
    // }

    answer1 = '$sum';
  }

  @override
  void part2() {
    answer2 = 'ran 2';
  }
}

class Node {
  String character;
  List<String> entry = [];

  Node(this.character);
}
// v<A<AA>^>AvAA^<A>Av<<A>^>AvA^Av<<A>^>AAvA<A^>A<A>Av<A<A>^>AAA<A>vA^A
// <vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A
// v<A<AA>^>Av<<A>A<A>^>AvA^<A>vA^AvAA^<A>Av<<A>^>AvA^Av<<A>^>AAvA<A^>Av<A>A^A<A>Av<A<A>^>Av<<A>A^>AAA<A>vA^AvA^<A>A
// v<A<AA>^>Av<<A>A<A>^>AvA^<A>vA^AvAA^<A>Av<<A>^>AvA^Av<<A>^>AAvA<A^>Av<A>A^A<A>Av<<A>^>AvA<A^>Av<A>A^A<Av<A>^>Av<<A>^A>AvA^Av<A^>A<Av<A>^>Av<<A>^A>AAvA^Av<A<A>^>Av<<A>A^>AAA<A>vA^AvA^<A>A
// v<<A>A<A>^>AvAA^<A>Av<<A>^>AvA^Av<<A>^>AAv<A>A^A<A>Av<<A>A^>AAAvA^<A>A

//<vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A
//v<<A>>^A<A>AvA<^AA>A<vAAA>^A
//<A^A>^^AvvvA
//029A

//v<<A>>^A<A>AvA<^AA>A<vAAA>^A
//v<<A>>^A<A>A<AA>vA^Av<AAA^>A
// 029A: <vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A
// 980A: <v<A>>^AAAvA^A<vA<AA>>^AvAA<^A>A<v<A>A>^AAAvA<^A>A<vA>^A<A>A
// 179A: <v<A>>^A<vA<A>>^AAvAA<^A>A<v<A>>^AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A
// 456A: <v<A>>^AA<vA<A>>^AAvAA<^A>A<vA>^A<A>A<vA>^A<A>A<v<A>A>^AAvA<^A>A
// 379A: <v<A>>^AvA^A<vA<AA>>^AAvA<^A>AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A
//       v<<A>^>AvA^Av<<A>^>AAv<A<A>^>AAvAA^<A>Av<A^>AA<A>Av<A<A>^>AAA<A>vA^A
