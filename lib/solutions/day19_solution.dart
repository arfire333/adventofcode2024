import 'package:adventofcode2024/mixins/solution.dart';

class Node {
  String val;

  Node(this.val);

  Set<(Node, int)> options = {};
}

class Day19Solution with Solution {
  Set<String> alphabet = {};
  List<String> words = [];
  @override
  int get year => 2024;

  @override
  int get day => 19;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    alphabet = lines[0].split(', ').toSet();
    for (int i = 2; i < lines.length; i++) {
      if (lines[i].isEmpty) {
        continue;
      }
      words.add(lines[i]);
    }

    dataIsValid = true;
  }

  @override
  void part1() {
    int count = 0;
    for (var w in words) {
      Set<int> curr = {0};
      int longest = 0;
      do {
        Set<int> next = {};
        for (var start in curr) {
          for (var symbol in alphabet) {
            if (w.startsWith(symbol, start)) {
              next.add(start + symbol.length);
              if (longest < start + symbol.length) {
                longest = start + symbol.length;
              }
            }
          }
        }
        curr = next;
      } while (curr.isNotEmpty && longest < w.length);
      if (longest == w.length) {
        count++;
      }
    }
    answer1 = '$count';
  }

  int? good(String w, int start, Map<int, int> cache) {
    if (start == w.length) {
      return 1;
    }
    if (cache.containsKey(start)) {
      return cache[start];
    }

    int retVal = 0;

    Set<int> next = {};
    for (var symbol in alphabet) {
      if (w.startsWith(symbol, start)) {
        next.add(start + symbol.length);
      }
    }
    for (var nextStart in next) {
      retVal += good(w, nextStart, cache)!;
    }
    cache[start] = retVal;
    return retVal;
  }

  @override
  void part2() {
    int count = 0;
    for (var w in words) {
      Map<int, int> cache = {};
      count += good(w, 0, cache)!;
    }
    answer2 = '$count';
  }
}
