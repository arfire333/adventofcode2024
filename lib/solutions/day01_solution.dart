import 'package:adventofcode2024/mixins/solution.dart';

class Day01Solution with Solution {
  List<int> left = List<int>.empty(growable: true);
  List<int> right = List<int>.empty(growable: true);
  List<int> sortedLeft = List<int>.empty(growable: true);
  List<int> sortedRight = List<int>.empty(growable: true);

  @override
  void parse(String rawData) {
    // Don't forget to clear data
    left.clear();
    right.clear();

    var lines = rawData.split('\n');
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      final re = RegExp(r'( +)');
      var entries = line.split(re);

      left.add(int.parse(entries[0]));
      right.add(int.parse(entries[1]));
    }

    dataIsValid = true;
  }

  @override
  void part1() {
    sortedLeft = List<int>.from(left);
    sortedLeft.sort();
    sortedRight = List<int>.from(right);
    sortedRight.sort();
    var sum = 0;

    for (int i = 0; i < sortedLeft.length; i++) {
      sum += (sortedLeft[i] > sortedRight[i]
          ? sortedLeft[i] - sortedRight[i]
          : sortedRight[i] - sortedLeft[i]);
    }

    answer1 = '$sum';
  }

  @override
  void part2() {
    // This is only correct because the left column of
    // my data was unique.  It does not work with the
    // sample data.
    Map<int, int> counts = <int, int>{};
    for (var value in left) {
      counts[value] = 0;
    }

    for (var value in right) {
      int last = counts[value] ?? -1;
      if (last >= 0) {
        counts[value] = last + 1;
      }
    }

    var total = 0;
    counts.forEach((key, value) {
      total += key * value;
    });

    answer2 = '$total';
  }

  @override
  int get day => 1;

  @override
  int get year => 2024;
}
