import 'package:adventofcode2024/solutions/day17_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "Register A: 729\n"
    "Register B: 0\n"
    "Register C: 0\n"
    "\n"
    "Program: 0,1,5,4,3,0\n";

String loopData = "Register A: 2024\n"
    "Register B: 0\n"
    "Register C: 0\n"
    "\n"
    "Program: 0,3,5,4,3,0\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Parse', () {
    Day17Solution s = Day17Solution();
    s.parse(rawData);
    expect(s.A, 729);
    expect(s.B, 0);
    expect(s.C, 0);
    expect(s.instructions.length, 6);
  });

  test('Part 1', () {
    Day17Solution s = Day17Solution();
    s.parse(rawData);
    s.part1();
    expect(s.answer1, '4,6,3,5,6,3,5,2,1,0');
  });

  test('Part 2', () {
    Day17Solution s = Day17Solution();
    s.parse(loopData);
    s.part2();
    expect(s.answer2, '117440');
  });
}
