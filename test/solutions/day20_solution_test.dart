import 'package:adventofcode2024/solutions/day20_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData =
//
    "###############\n"
    "#...#...#.....#\n"
    "#.#.#.#.#.###.#\n"
    "#S#...#.#.#...#\n"
    "#######.#.#.###\n"
    "#######.#.#...#\n"
    "#######.#.###.#\n"
    "###..E#...#...#\n"
    "###.#######.###\n"
    "#...###...#...#\n"
    "#.#####.#.###.#\n"
    "#.#...#.#.#...#\n"
    "#.#.#.#.#.#.###\n"
    "#...#...#...###\n"
    "###############\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse', () {
    Day20Solution s = Day20Solution();
    s.parse(rawData);
    expect(s.points.length, 85);
    expect(s.start, Point(3, 1));
    expect(s.stop, Point(7, 5));
  });
  test('Part 1', () {
    Day20Solution s = Day20Solution();
    s.parse(rawData);
    s.cheatThreshold = 36;
    s.part1();
    expect(s.answer1, '4');
    // 1374 to high
  });
  test('Part 1 2', () {
    Day20Solution s = Day20Solution();
    s.parse(rawData);
    s.cheatThreshold = 6;
    s.part1();
    expect(s.answer1, '16');
    // 1374 to high
  });

  test('Part 2 Given', () {
    Day20Solution s = Day20Solution();
    s.parse(rawData);
    s.cheatThreshold = 50;
    s.cheatMaxLength = 20;
    s.part2();
    expect(s.answer2, '285');
    // 8780 too low

    // 431283 too low
    // 253653
  });
}
