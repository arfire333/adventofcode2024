import 'package:adventofcode2024/solutions/day10_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = r"";

void main() async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Part 1', () async {
    Day10Solution solution = Day10Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, 'ranit');
  });

  test('Part 2', () async {
    Day10Solution solution = Day10Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, 'ran 2');
  });
}
