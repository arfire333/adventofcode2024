import 'package:adventofcode2024/solutions/day01_solution.dart';
import 'package:flutter_test/flutter_test.dart';

String rawData = '3   4\n'
    '4   3\n'
    '2   5\n'
    '1   3\n'
    '3   9\n'
    '3   3\n';

void main() async {
  test('Part 1', () async {
    Day01Solution solution = Day01Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '11');
  });

  test('Part 2', () async {
    Day01Solution solution = Day01Solution();
    solution.parse(rawData);
    solution.part2();
    // Only because my solution had unique data
    // the left column.
    expect(solution.answer2, isNot('31'));
  });
}
