import 'package:adventofcode2024/solutions/day25_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData =
//
    "#####\n"
    ".####\n"
    ".####\n"
    ".####\n"
    ".#.#.\n"
    ".#...\n"
    ".....\n"
    "\n"
    "#####\n"
    "##.##\n"
    ".#.##\n"
    "...##\n"
    "...#.\n"
    "...#.\n"
    ".....\n"
    "\n"
    ".....\n"
    "#....\n"
    "#....\n"
    "#...#\n"
    "#.#.#\n"
    "#.###\n"
    "#####\n"
    "\n"
    ".....\n"
    ".....\n"
    "#.#..\n"
    "###..\n"
    "###.#\n"
    "###.#\n"
    "#####\n"
    "\n"
    ".....\n"
    ".....\n"
    ".....\n"
    "#....\n"
    "#.#..\n"
    "#.#.#\n"
    "#####\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Parse', () {
    Day25Solution s = Day25Solution();
    s.parse(rawData);
  });

  test('Part 1', () {
    Day25Solution s = Day25Solution();
    s.parse(rawData);
    s.part1();
    expect(s.answer1, '3');
  });
}
