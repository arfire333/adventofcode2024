import 'package:adventofcode2024/solutions/day18_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData =
//
    "5,4\n"
    "4,2\n"
    "4,5\n"
    "3,0\n"
    "2,1\n"
    "6,3\n"
    "2,4\n"
    "1,5\n"
    "0,6\n"
    "3,3\n"
    "2,6\n"
    "5,1\n"
    "1,2\n"
    "5,5\n"
    "2,5\n"
    "6,5\n"
    "1,4\n"
    "0,4\n"
    "6,4\n"
    "1,1\n"
    "6,1\n"
    "1,0\n"
    "0,5\n"
    "1,6\n"
    "2,0\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse', () {
    Day18Solution s = Day18Solution();
    s.parse(rawData, rows: 7, cols: 7);
    expect(s.bytes.length, 25);
    expect(s.bytes.contains(Point(6, 1)), true);
  });

  test('Part 1', () {
    Day18Solution s = Day18Solution();
    s.parse(rawData, rows: 7, cols: 7);
    s.part1tics = 12;
    s.part1();
    expect(s.answer1, '22');
  });

  test('Part 2', () {
    Day18Solution s = Day18Solution();
    s.parse(rawData, rows: 7, cols: 7);
    s.part1tics = 12;
    s.part2();
    expect(s.answer2, '6,1');
  });
}
