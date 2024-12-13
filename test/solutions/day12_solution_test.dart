import 'package:adventofcode2024/solutions/day12_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "AAAA\n"
    "BBCD\n"
    "BBCC\n"
    "EEEC\n";

String rawDataSplitRegions = "00000\n"
    "0x0x0\n"
    "00000\n"
    "0x0x0\n"
    "00x00\n";

String largeExample = "RRRRIICCFF\n"
    "RRRRIICCCF\n"
    "VVRRRCCFFF\n"
    "VVRCCCJFFF\n"
    "VVVVCJJCFE\n"
    "VVIVCCJJEE\n"
    "VVIIICJJEE\n"
    "MIIIIIJJEE\n"
    "MIIISIJEEE\n"
    "MMMISSJEEE\n";

String eExample = "EEEEE\n"
    "EXXXX\n"
    "EEEEE\n"
    "EXXXX\n"
    "EEEEE\n";

String anotherExample = "AAAAAA\n"
    "AAABBA\n"
    "AAABBA\n"
    "ABBAAA\n"
    "ABBAAA\n"
    "AAAAAA\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse', () {
    Day12Solution solution = Day12Solution();
    solution.parse(rawData);
    for (int i = 0; i < solution.regions.length - 1; i++) {
      for (int j = i + 1; j < solution.regions.length; j++) {
        if (solution.regions[i].id == solution.regions[j].id) {
          solution.union(i, j);
        }
      }
    }
    List<int> answer = [
      //
      0, 3, 4, 4, -4, 9, 10, 12, -1, 10, -4, 16, 16, 14, 15, -3, -4
    ];
    expect(solution.groups, answer);
  });

  test('SplitPlotRegions', () {
    Day12Solution solution = Day12Solution();
    solution.parse(rawDataSplitRegions);
    solution.part1();
    expect(solution.numRegions(), 6);
  });

  test('Part 1', () {
    Day12Solution solution = Day12Solution();
    solution.parse(largeExample);
    solution.part1();
    expect(solution.answer1, '1930');
  });

  test('Part 2', () {
    Day12Solution solution = Day12Solution();
    solution.parse(largeExample);
    solution.part2();
    expect(solution.answer2, '1206');
    // 846196 to low
  });
  test('E Part 2', () {
    Day12Solution solution = Day12Solution();
    solution.parse(eExample);
    solution.part2();
    expect(solution.answer2, '236');
    // 846196 to low
  });
  test('Another Part 2', () {
    Day12Solution solution = Day12Solution();
    solution.parse(anotherExample);
    solution.part2();
    expect(solution.answer2, '368');
    // 846196 to low
  });
}
