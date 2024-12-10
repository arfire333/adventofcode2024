import 'package:adventofcode2024/solutions/day04_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "MMMSXXMASM\n"
    "MSAMXMSMSA\n"
    "AMXSXMAAMM\n"
    "MSAMASMSMX\n"
    "XMASAMXAMM\n"
    "XXAMMXXAMA\n"
    "SMSMSASXSS\n"
    "SAXAMASAAA\n"
    "MAMMMXMMMM\n"
    "MXMXAXMASX\n";

void main() async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Part 1', () async {
    Day04Solution solution = Day04Solution();
    solution.parse(rawData);
    expect(solution.puzzle.length, 10);
    solution.part1();
    expect(solution.answer1, '18');
  });
  test('Part 2', () async {
    Day04Solution solution = Day04Solution();
    solution.parse(rawData);
    expect(solution.puzzle.length, 10);
    solution.part2();
    expect(solution.answer2, '9');
  });
}
