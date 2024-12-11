import 'package:adventofcode2024/solutions/day11_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = r"125 17";

void main() async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Parse', () async {
    Day11Solution solution = Day11Solution();
    solution.parse(rawData);
    solution.parse(rawData);
    expect(solution.stoneLine.nodes.length, 2);
    expect(solution.stoneLine.nodes[0].value, '125');
    expect(solution.stoneLine.nodes[1].value, '17');
  });

  test('Part 1', () async {
    Day11Solution solution = Day11Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '55312');
  });

  test('Part 2', () async {
    Day11Solution solution = Day11Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '55312');
    solution.part2();
    expect(solution.answer2, '65601038650482');
  });
}
