// tree, read text, and verify that the values of widget properties are correct.

import 'package:adventofcode2024/solutions/day05_solution.dart';
import 'package:flutter_test/flutter_test.dart';

String rawData = r"";

void main() async {
  test('Part 1', () async {
    Day05Solution solution = Day05Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, 'ranit');
  });

  test('Part 2', () async {
    Day05Solution solution = Day05Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, 'ran 2');
  });
}
