import 'package:adventofcode2024/solutions/day19_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData =
//
    "r, wr, b, g, bwu, rb, gb, br\n"
    "\n"
    "brwrr\n"
    "bggr\n"
    "gbbr\n"
    "rrbgbr\n"
    "ubwu\n"
    "bwurrg\n"
    "brgr\n"
    "bbrgwb\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse', () {
    Day19Solution s = Day19Solution();
    s.parse(rawData);
    expect(s.alphabet.length, 8);
    expect(s.words.length, 8);
  });
  test('Part 1', () {
    Day19Solution s = Day19Solution();
    s.parse(rawData);
    s.part1();
    expect(s.answer1, '6');
  });

  test('Part 2', () {
    Day19Solution solution = Day19Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, '16');
    // 44399 to low
  });
}
