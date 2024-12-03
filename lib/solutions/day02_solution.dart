import 'package:adventofcode2024/data.dart' as puzzle_data;

class Day02Solution {
  bool dataIsValid = false;
  String answer1 = 'tbd';
  String answer2 = 'tbd';

  List<List<int>> reports = List<List<int>>.empty(growable: true);

  Future<void> fetchData(int year, int day) async {
    var rawData = await puzzle_data.fetchPuzzleData(year, day);

    if (rawData == null) {
      answer1 = 'Error getting data.';
      answer2 = 'Error getting data.';
      return;
    }
    parse(rawData);
  }

  void parse(String rawData) {
    // Don't forget to clear data
    reports.clear();

    var lines = rawData.split('\n');
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var entries = line.split(RegExp(r'\s+'));
      List<int> currentReport = List<int>.empty(growable: true);
      for (var value in entries) {
        currentReport.add(int.parse(value));
      }
      reports.add(currentReport);
    }

    dataIsValid = true;
  }

  void part1() {
    int safeCount = 0;

    for (var report in reports) {
      // assume safe first
      bool safe = true;
      int last = report[0];
      // Decide if it is increasing or decreasing.
      bool increasing = report[1] > last;
      for (int i = 1; i < report.length; i++) {
        if (increasing) {
          int delta = report[i] - report[i - 1];
          if (delta < 1 || delta > 3) {
            safe = false;
          }
        } else {
          int delta = report[i - 1] - report[i];
          if (delta < 1 || delta > 3) {
            safe = false;
          }
        }
      }
      if (safe) {
        safeCount += 1;
      }
    }
    answer1 = '$safeCount';
  }

  void part2() {
    int safeCount = 0;

    for (var report in reports) {
      // assume safe first
      if (isSafe(report, -1, 0, true, 0)) {
        safeCount++;
      } else if (isSafe(report, -1, 0, false, 0)) {
        safeCount++;
      }
    }
    answer2 = '$safeCount';
  }

  bool isSafe(List<int> a, int lastIndex, int currentIndex, bool increasing,
      int dropCount) {
    if (currentIndex >= a.length && dropCount <= 1) {
      return true;
    }
    if (dropCount > 1) {
      return false;
    }
    int delta = (increasing ? 1 : -1);
    if (lastIndex >= 0) {
      delta = a[currentIndex] - a[lastIndex];
    }

    int error = 0;
    if (increasing && (delta < 1 || delta > 3)) {
      error = 1;
    } else if (!increasing && (delta > -1 || delta < -3)) {
      error = 1;
    }

    bool result = false;
    // keep current
    var nextIndex = currentIndex + 1;
    if (error == 0) {
      result |= isSafe(a, currentIndex, nextIndex, increasing, dropCount);
    }
    // drop current
    result |= isSafe(a, lastIndex, nextIndex, increasing, dropCount + 1);

    return result;
  }
}
