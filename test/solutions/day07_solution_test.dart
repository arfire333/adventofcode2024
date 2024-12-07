// tree, read text, and verify that the values of widget properties are correct.

import 'package:adventofcode2024/solutions/day07_solution.dart';
import 'package:flutter_test/flutter_test.dart';

String rawData = "190: 10 19\n"
    "3267: 81 40 27\n"
    "83: 17 5\n"
    "156: 15 6\n"
    "7290: 6 8 6 15\n"
    "161011: 16 10 13\n"
    "192: 17 8 14\n"
    "21037: 9 7 18 13\n"
    "292: 11 6 16 20\n";

void main() async {
  test('Parse', () async {
    Day07Solution solution = Day07Solution();
    solution.parse(rawData);
    expect(solution.testValues,
        [190, 3267, 83, 156, 7290, 161011, 192, 21037, 292]);
    expect(solution.testInputs, [
      [10, 19],
      [81, 40, 27],
      [17, 5],
      [15, 6],
      [6, 8, 6, 15],
      [16, 10, 13],
      [17, 8, 14],
      [9, 7, 18, 13],
      [11, 6, 16, 20]
    ]);
  });
  test('Part 1', () async {
    Day07Solution solution = Day07Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '3749');
  });

  test('Part 2', () async {
    Day07Solution solution = Day07Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, '11387');
  });

  test('Concat', () {
    Day07Solution solution = Day07Solution();
    expect(solution.concat(23, 45), 2345);
    expect(solution.concat(23, 0), 230);
    expect(solution.concat(15, 6), 156);
  });
  test('OperatorCheck', () {
    Day07Solution solution = Day07Solution();

    expect(solution.operatorCheck(156, [15, 6], 0, 0), false);
    expect(solution.operatorCheck(156, [15, 6], 0, 0, extraOp: true), true);
  });
  test('Trouble', () {
    Day07Solution solution = Day07Solution();

    expect(solution.operatorCheck(7290, [6, 8, 6, 15], 0, 0), false);
    expect(
        solution.operatorCheck(7290, [6, 8, 6, 15], 0, 0, extraOp: true), true);
  });
}
