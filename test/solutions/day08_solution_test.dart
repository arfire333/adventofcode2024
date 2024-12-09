// tree, read text, and verify that the values of widget properties are correct.

import 'package:adventofcode2024/solutions/day08_solution.dart';
import 'package:flutter_test/flutter_test.dart';

String rawData = "............\n"
    "........0...\n"
    ".....0......\n"
    ".......0....\n"
    "....0.......\n"
    "......A.....\n"
    "............\n"
    "............\n"
    "........A...\n"
    ".........A..\n"
    "............\n"
    "............\n";

void main() async {
  test('Part 1', () async {
    Day08Solution solution = Day08Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '14');
  });

  test('Part 2', () async {
    Day08Solution solution = Day08Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, '34');
  });
}
