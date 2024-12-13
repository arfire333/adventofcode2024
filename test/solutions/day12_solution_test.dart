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

    for (int i = 0; i < solution.groups.length; i++) {
      if (solution.groups[i] < 0) {
        int count = -solution.groups[i];
        print('$count => ${solution.regions[i].id}');
      }
    }
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

  test('Pricing', () {});

  test('Region Tests', () {
    expect(Region('a', 0, 0).price(), 0);
    expect(Region('b', 3, 4).price(), 12);
    // ({int r, int c}) g = (r: 4, c: 2);
    // ({int r, int c}) b = (r: 4, c: 2);
    // (int, int) e = (4, 2);
    // print(e == e ? "true" : "false");
    // print(g == e ? "true" : "false");
    // print(g == b ? "true" : "false");
    // var (:r, :c) = g;
    // print('$r , $c');

    var (a, b, c) = returnRecord();
    print('$a $b $c');

    var d = returnRecord();
    print('${d.$1}  ${d.$2}  ${d.$3}');
  });
}

(int, int, String) returnRecord() {
  return (3, 4, 'Dog');
}
