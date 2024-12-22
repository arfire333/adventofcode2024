import 'package:adventofcode2024/solutions/day22_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData =
//
    "1\n"
    "10\n"
    "100\n"
    "2024\n";

String p2Data =
//
    "1\n"
    "2\n"
    "3\n"
    "2024\n";

String p2PricesData =
//
    "123\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Part 1', () {
    Day22Solution s = Day22Solution();
    s.parse(rawData);
  });

  test('Part 1', () {
    Day22Solution solution = Day22Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '37327623');
  });

  test('Part 2 Prices', () {
    Day22Solution solution = Day22Solution();
    solution.parse(p2PricesData);
    solution.part2();
    expect(solution.answer2, 'ran 2');
  });
  test('Part 2', () {
    Day22Solution solution = Day22Solution();
    solution.parse(p2Data);
    solution.part2();
    expect(solution.answer2, '23');
  });
}
