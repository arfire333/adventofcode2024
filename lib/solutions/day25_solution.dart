import 'package:adventofcode2024/mixins/solution.dart';

class Day25Solution with Solution {
  List<List<int>> locks = [];
  List<List<int>> keys = [];
  @override
  int get year => 2024;

  @override
  int get day => 25;

  int accumulator2number(List<int> acc) {
    int val = 0;
    for (int i = 0; i < acc.length; i++) {
      val *= 10;
      val += acc[i];
    }

    return val;
  }

  bool keyFits(List<int> key, List<int> lock) {
    for (int i = 0; i < key.length; i++) {
      if (key[i] + lock[i] > 5) {
        return false;
      }
    }
    return true;
  }

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    List<int> lockAccumulator = [-1, -1, -1, -1, -1];
    List<int> keyAccumulator = [-1, -1, -1, -1, -1];
    bool lockDetect = false;
    bool isLock = true;
    for (var line in lines) {
      if (line.isEmpty) {
        if (lockDetect) {
          if (isLock) {
            locks.add(lockAccumulator);
          } else {
            keys.add(keyAccumulator);
          }
          lockAccumulator = [-1, -1, -1, -1, -1];
          keyAccumulator = [-1, -1, -1, -1, -1];
          lockDetect = false;
        }
        continue;
      }
      if (!lockDetect) {
        isLock = (line[0] == '#');
        lockDetect = true;
      }

      for (int i = 0; i < line.length; i++) {
        int val = line[i] == '#' ? 1 : 0;
        if (isLock) {
          lockAccumulator[i] += val;
        } else {
          keyAccumulator[i] += val;
        }
      }
    }

    dataIsValid = true;
  }

  @override
  void part1() {
    int count = 0;
    for (var key in keys) {
      for (var lock in locks) {
        if (keyFits(key, lock)) {
          count++;
        }
      }
    }
    answer1 = '$count';
  }

  @override
  void part2() {
    answer2 = 'Need 2 More';
  }
}
