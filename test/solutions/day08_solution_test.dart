import 'package:adventofcode2024/solutions/day08_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

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
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
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
