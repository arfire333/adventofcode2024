import 'package:adventofcode2024/solutions/day13_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "Button A: X+94, Y+34\n"
    "Button B: X+22, Y+67\n"
    "Prize: X=8400, Y=5400\n"
    "\n"
    "Button A: X+26, Y+66\n"
    "Button B: X+67, Y+21\n"
    "Prize: X=12748, Y=12176\n"
    "\n"
    "Button A: X+17, Y+86\n"
    "Button B: X+84, Y+37\n"
    "Prize: X=7870, Y=6450\n"
    "\n"
    "Button A: X+69, Y+23\n"
    "Button B: X+27, Y+71\n"
    "Prize: X=18641, Y=10279\n";

List<(int, int)> A = [(94, 34), (26, 66), (17, 86), (69, 23)];
List<(int, int)> B = [(22, 67), (67, 21), (84, 37), (27, 71)];
List<(int, int)> P = [
  (8400, 5400),
  (12748, 12176),
  (7870, 6450),
  (18641, 10279)
];

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse ', () {
    Day13Solution solution = Day13Solution();
    solution.parse(rawData);

    expect(solution.A, A);
    expect(solution.B, B);
    expect(solution.P, P);
  });

  test('Part 1', () {
    Day13Solution solution = Day13Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '480');
    // 30742 was to high
  });

  test('Part 2', () {
    Day13Solution solution = Day13Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, '875318608908');
    // 36344285665221 to low
    // 57473109610814 to low
  });
}
