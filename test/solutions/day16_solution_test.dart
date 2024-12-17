import 'package:adventofcode2024/solutions/day16_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "###############\n"
    "#.......#....E#\n"
    "#.#.###.#.###.#\n"
    "#.....#.#...#.#\n"
    "#.###.#####.#.#\n"
    "#.#.#.......#.#\n"
    "#.#.#####.###.#\n"
    "#...........#.#\n"
    "###.#.#####.#.#\n"
    "#...#.....#.#.#\n"
    "#.#.#.###.#.#.#\n"
    "#.....#...#.#.#\n"
    "#.###.#.#.#.#.#\n"
    "#S..#.....#...#\n"
    "###############\n";
void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse', () {
    Day16Solution solution = Day16Solution();
    solution.parse(rawData);
    expect(solution.start.r, 13);
    expect(solution.start.c, 1);
    expect(solution.maze.length, 15);
    expect(solution.maze[0].length, 15);
  });
  test('Part 1', () {
    Day16Solution s = Day16Solution();
    s.parse(rawData);
    s.part1();
    expect(s.answer1, '7036');
  });

  test('Part 2', () {
    Day16Solution solution = Day16Solution();
    solution.parse(rawData);
    solution.part1();
    solution.part2();
    expect(solution.answer2, '45');
  });
}
