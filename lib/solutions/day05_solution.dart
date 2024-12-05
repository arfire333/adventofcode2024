import 'package:adventofcode2024/data.dart' as puzzle_data;
import 'package:html/parser.dart' as html;
import 'dart:developer' as dev;

class Day05Solution {
  Map<int, Set<int>> orderRules = {};
  Map<int, Set<int>> reverseOrderRules = {};
  List<List<int>> updates = [];
  Set<int> badUpdates = {};
  String puzzleText = '';
  bool dataIsValid = false;
  String answer1 = 'tbd';
  String answer2 = 'tbd';

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
    var lines = rawData.split('\n');
    // Parse rules
    bool parseRules = true;
    for (var line in lines) {
      if (line.isEmpty) {
        parseRules = false;
        continue;
      }
      if (parseRules) {
        var s = line.split('|');
        int key = int.parse(s[0]);
        int val = int.parse(s[1]);

        if (!orderRules.containsKey(key)) {
          orderRules[key] = {val};
        } else {
          orderRules[key]?.add(val);
        }
        if (!reverseOrderRules.containsKey(val)) {
          reverseOrderRules[val] = {key};
        } else {
          reverseOrderRules[val]?.add(key);
        }
      } else {
        var sList = line.split(',');
        List<int> newUpdate = [];
        for (var val in sList) {
          newUpdate.add(int.parse(val));
        }
        updates.add(newUpdate);
        dev.log('${newUpdate.toString()}');
      }
    }
    dev.log('Order rules');
    for (var ruleList in orderRules.entries) {
      dev.log('${ruleList.key} ${ruleList.value.toString()}');
    }
    dev.log('Reverse order rules');
    for (var ruleList in reverseOrderRules.entries) {
      dev.log('${ruleList.key} ${ruleList.value.toString()}');
    }

    dataIsValid = true;
  }

  void part1() {
    int answer = 0;

    for (int j = 0; j < updates.length; j++) {
      var update = updates[j];
      Set<int> checked = {};
      // Assume it's good
      bool good = true;
      for (int i = update.length - 1; i >= 0; i--) {
        var num = update[i];
        for (var val in checked) {
          if (orderRules[val]?.contains(num) ?? false) {
            // stop when it's not good
            good = false;
            badUpdates.add(j);
            break;
          }
        }
        checked.add(num);
        if (!good) {
          break;
        }
      }
      if (good) {
        answer += update[update.length >> 1];
      }
    }

    answer1 = '$answer';
  }

  int updateCompare(int a, int b) {
    if (orderRules[a]?.contains(b) ?? false) {
      return 1;
    }
    if (orderRules[b]?.contains(a) ?? false) {
      return -1;
    }
    return 0;
  }

  void part2() {
    int answer = 0;
    for (var i in badUpdates) {
      updates[i].sort(updateCompare);
      answer += updates[i][updates[i].length >> 1];
    }
    answer2 = '$answer';
  }
}
