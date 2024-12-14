import 'package:adventofcode2024/solutions/day14_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "p=0,4 v=3,-3\n"
    "p=6,3 v=-1,-3\n"
    "p=10,3 v=-1,2\n"
    "p=2,0 v=2,-1\n"
    "p=0,0 v=1,3\n"
    "p=3,0 v=-2,-2\n"
    "p=7,6 v=-1,-3\n"
    "p=3,0 v=-1,-2\n"
    "p=9,3 v=2,3\n"
    "p=7,3 v=-1,2\n"
    "p=2,4 v=2,-3\n"
    "p=9,5 v=-3,-3\n";

var gridSize = (7, 11);
var actualGridSize = (101, 103);

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Parse', () {
    Day14Solution solution = Day14Solution();
    solution.parse(rawData);
    expect(solution.robots[0].x, 0);
    expect(solution.robots[0].y, 4);
    expect(solution.robots[0].vx, 3);
    expect(solution.robots[0].vy, -3);
    expect(solution.robots.length, 12);
  });

  test('Part 1', () {
    Day14Solution solution = Day14Solution();
    solution.parse(rawData);
    solution.part1();
    // Adjusted for full board size.
    expect(solution.answer1, '21');
  });
}
