import 'package:adventofcode2024/solutions/day06_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "....#.....\n"
    ".........#\n"
    "..........\n"
    "..#.......\n"
    ".......#..\n"
    "..........\n"
    ".#..^.....\n"
    "........#.\n"
    "#.........\n"
    "......#...\n";

String rawData2 = "....#.....\n"
    ".........#\n"
    "..........\n"
    "...#......\n"
    "......#...\n"
    "..........\n"
    "....^.....\n"
    "..........\n"
    "..........\n"
    "..........\n";

// dart format off
var moveTest = '.#........\n'
    '..........\n'
    '...#......\n'
    '..........\n'
    '...#...#..\n'
    '......#.#.\n'
    '.......#..\n'
    '......#...\n'
    '.......#..\n'
    '......#...\n';
int answer2 = 2;

void main() async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Part 1', () async {
    Day06Solution solution = Day06Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '41');
    solution.part1();
    expect(solution.answer1, '41');
  });

  test('Part 2', () async {
    Day06Solution solution = Day06Solution();
    solution.parse(rawData);
    solution.part1();
    solution.part2();
    expect(solution.answer2, '6');
  });
  test('Part 2a', () async {
    Day06Solution solution = Day06Solution();
    solution.parse(rawData2);
    solution.part1();
    solution.part2();
    expect(solution.answer2, '$answer2');
  });

  test('Pair Add', () {
    Pair a = Pair(0, 0);
    a = a + possibleDeltas['>']!;
    expect(a, Pair(0, 1));
    a = a + possibleDeltas['^']!;
    expect(a, Pair(-1, 1));
    a = a + possibleDeltas['<']!;
    expect(a, Pair(-1, 0));
    a = a + possibleDeltas['v']!;
    expect(a, Pair(0, 0));
  });

  test('Position Set', () {
    Set<Guard> visited = {};
    var pos1 = Guard(Pair(0, 0), '^');
    var pos2 = Guard(Pair(0, 0), '^');
    visited.add(pos1);
    expect(visited.length, 1);
    visited.add(pos2);
    expect(visited.length, 1);
  });

  List<List<String>> board = [];
  var lines = moveTest.split("\n");
  for (var line in lines) {
    if (line.isEmpty) {
      continue;
    }
    board.add(line.split(''));
  }
  printBoard(board);
  test('Free Moves', () {
    Guard u = Guard(Pair(1, 1), '^');
    expect(move2(u, board), Guard(Pair(1, 2), '>'));
    Guard r = Guard(Pair(2, 2), '>');
    expect(move2(r, board), Guard(Pair(3, 2), 'v'));
    Guard d = Guard(Pair(3, 3), 'v');
    expect(move2(d, board), Guard(Pair(3, 2), '<'));
    Guard l = Guard(Pair(4, 4), '<');
    expect(move2(l, board), Guard(Pair(3, 4), '^'));
    expect(move2(Guard(Pair(8, 6), '^'), board), Guard(Pair(8, 5), '<'));
    expect(move2(Guard(Pair(7, 7), 'v'), board), Guard(Pair(7, 8), '>'));
  });
  test('Trapped Move', () {
    expect(move2(Guard(Pair(5, 7), 'v'), board), Guard(Pair(5, 7), 'v'));
  });
}
