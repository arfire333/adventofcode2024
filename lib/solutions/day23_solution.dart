import 'package:adventofcode2024/mixins/solution.dart';
import 'package:collection/collection.dart';

class Day23Solution with Solution {
  Map<String, List<String>> nodeConnections = {};
  List<String> nodes = [];
  EqualitySet<Set<String>> sets = EqualitySet(const SetEquality());

  @override
  int get year => 2024;

  @override
  int get day => 23;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    nodeConnections = {};
    nodes = [];
    Set<String> nodesSet = {};
    sets.clear();
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var split = line.split('-');
      nodeConnections.update(
        split[0],
        (val) {
          if (!val.contains(split[1])) {
            val.add(split[1]);
          }
          return val;
        },
        ifAbsent: () {
          return [split[1]];
        },
      );
      nodeConnections.update(
        split[1],
        (val) {
          if (!val.contains(split[0])) {
            val.add(split[0]);
          }
          return val;
        },
        ifAbsent: () {
          return [split[0]];
        },
      );
      nodesSet.add(split[0]);
      nodesSet.add(split[1]);
    }
    nodes.addAll(nodesSet);

    dataIsValid = true;
  }

  bool part2ValidSet(Set<String> set) {
    for (var a in set) {
      for (var b in set) {
        if (a == b) {
          continue;
        }
        if (nodeConnections[a]!.contains(b)) {
          continue;
        }
        return false;
      }
    }
    return true;
  }

  bool part1ValidSet(Set<String> set) {
    bool hasT = false;
    for (var a in set) {
      if (a[0] == 't') {
        hasT = true;
      }
      for (var b in set) {
        if (a == b) {
          continue;
        }
        if (nodeConnections[a]!.contains(b)) {
          continue;
        }
        return false;
      }
    }
    return hasT;
  }

  void buildSets(List<String> source, Set<String> set, int curr, int goal) {
    if (set.length == goal) {
      if (part1ValidSet(set)) {
        sets.add(set);
      }
      return;
    }
    if (curr >= source.length) {
      return;
    }
    Set<String> nextSetWith = Set.from(set);
    Set<String> nextSetWithout = Set.from(set);
    nextSetWith.add(source[curr]);
    buildSets(source, nextSetWith, curr + 1, goal);
    buildSets(source, nextSetWithout, curr + 1, goal);
  }

  @override
  void part1() {
    for (var entry in nodeConnections.entries) {
      buildSets(entry.value, {entry.key}, 0, 3);
    }

    answer1 = '${sets.length}';
  }

  @override
  void part2() {
    sets.clear();
    Set<int> maxGroups = {};
    for (var node in nodeConnections.entries) {
      maxGroups.add(node.value.length);
    }
    List<int> groups = List.from(maxGroups);
    groups.sort();
    for (var t in groups.reversed) {
      for (var entry in nodeConnections.entries) {
        buildSets(entry.value, {entry.key}, 0, t);
        if (sets.isNotEmpty) {
          t = nodes.length;
          break;
        }
      }
    }
    List<String> a = List.from(sets.first);
    a.sort();
    answer2 = a[0];
    for (int i = 1; i < a.length; i++) {
      answer2 = '$answer2,${a[i]}';
    }
  }
}
