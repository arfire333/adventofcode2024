import 'package:adventofcode2024/solutions/day10_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "89010123\n"
    "78121874\n"
    "87430965\n"
    "96549874\n"
    "45678903\n"
    "32019012\n"
    "01329801\n"
    "10456732\n";

Set<(int, int)> expectedTrailHeads = {
  //
  (0, 2), (0, 4), (2, 4), (4, 6), (5, 2), (5, 5), (6, 0), (6, 6), (7, 1)
};

void main() async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parsing', () async {
    Day10Solution solution = Day10Solution();
    solution.parse(rawData);
    solution.parse(rawData);
    expect(solution.map, expectedMap);
    expect(solution.trailheads, expectedTrailHeads);
  });

  test('Part 1', () async {
    Day10Solution solution = Day10Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '36');
  });

  test('Part 2', () async {
    Day10Solution solution = Day10Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, '81');
  });
}

List<List<int>> expectedMap = [
  //
  [
    //
    8, 9, 0, 1, 0, 1, 2, 3,
  ],
  [
    //
    7, 8, 1, 2, 1, 8, 7, 4,
  ],
  [
    //
    8, 7, 4, 3, 0, 9, 6, 5,
  ],
  [
    //
    9, 6, 5, 4, 9, 8, 7, 4,
  ],
  [
    //
    4, 5, 6, 7, 8, 9, 0, 3,
  ],
  [
    //
    3, 2, 0, 1, 9, 0, 1, 2,
  ],
  [
    //
    0, 1, 3, 2, 9, 8, 0, 1,
  ],
  [
    //
    1, 0, 4, 5, 6, 7, 3, 2,
  ]
];
