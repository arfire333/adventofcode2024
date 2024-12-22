import 'dart:io';

import 'package:adventofcode2024/solutions/day21_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData =
//
    "029A\n"
    "980A\n"
    "179A\n"
    "456A\n"
    "379A\n";
String myData =
//
    "638A\n"
    "965A\n"
    "780A\n"
    "803A\n"
    "246A\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parse', () {
    Day21Solution s = Day21Solution();
    s.parse(rawData);
    s.part1();
    Map<int, Set<int>> dog = {};
    int key = 4;
    int newVal = 42;
    (dog[key] ??= {}).add(newVal);

    dog[4]?.add(52) ??
        [
          dog[4] = {52}
        ];
    expect(dog[4], {42, 52});
    dog.clear();

    dog[4]?.add(52) ??
        () {
          dog[4] = {52};
        };
    (dog[key] ??= {}).add(newVal);
    expect(dog[4], {42, 52});
  });
  test('Test A1', () {
    Day21Solution s = Day21Solution();
    s.parse(rawData);
    Set<String> paths = {};
    var (nr, nc) = s.numPadButton2Location['A']!;
    s.getNumPadList('1', '', {}, nr, nc, '', paths);

    expect(paths.length, 2);
    // expect(s.answer1, '126384');
  });
  test('Test 02', () {
    Day21Solution s = Day21Solution();
    s.parse(rawData);
    Set<String> paths = {};
    var (nr, nc) = s.numPadButton2Location['0']!;
    s.getNumPadList('2', '', {}, nr, nc, '', paths);

    expect(paths.length, 1);
    expect(paths.first, '^A');
    // expect(s.answer1, '126384');
  });
  test('Test A<', () {
    Day21Solution s = Day21Solution();
    s.parse(rawData);
    Set<String> paths = {};
    var (nr, nc) = s.dirPadButton2Location['A']!;
    s.getDirPadList('<', '', {}, nr, nc, '', paths);

    expect(paths.length, 2);
  });

  test('Part 1', () {
    Day21Solution s = Day21Solution();
    s.parse(rawData);
    s.part1();
    expect(s.answer1, '126384');
  });

  test('Part 2', () {
    Day21Solution s = Day21Solution();
    s.parse(rawData);
    s.part2();
    expect(s.answer2, 'ran 2');
  });
}
