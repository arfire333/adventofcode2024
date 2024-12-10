import 'package:adventofcode2024/mixins/solution.dart';
import 'dart:developer' as dev;

class Day05Solution with Solution {
  Map<int, Set<int>> orderRules = {};
  Map<int, Set<int>> reverseOrderRules = {};
  List<List<int>> updates = [];
  Set<int> badUpdates = {};
  @override
  @override
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
        dev.log(newUpdate.toString());
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

  @override
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

  @override
  void part2() {
    int answer = 0;
    for (var i in badUpdates) {
      updates[i].sort(updateCompare);
      answer += updates[i][updates[i].length >> 1];
    }
    answer2 = '$answer';
  }

  @override
  int get day => 5;

  @override
  int get year => 2024;
}
