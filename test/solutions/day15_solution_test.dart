import 'package:adventofcode2024/solutions/day15_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String smallAnswer = '2028';
String smallData = "########\n"
    "#..O.O.#\n"
    "##@.O..#\n"
    "#...O..#\n"
    "#.#.O..#\n"
    "#...O..#\n"
    "#......#\n"
    "########\n"
    "\n"
    "<^^>>>vv<v>>v<<\n";

String bigAnswer = '10092';
String bigData = "##########\n"
    "#..O..O.O#\n"
    "#......O.#\n"
    "#.OO..O.O#\n"
    "#..O@..O.#\n"
    "#O#..O...#\n"
    "#O..O..O.#\n"
    "#.OO.O.OO#\n"
    "#....O...#\n"
    "##########\n"
    "\n"
    "<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^\n"
    "vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v\n"
    "><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<\n"
    "<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^\n"
    "^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><\n"
    "^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^\n"
    ">^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^\n"
    "<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>\n"
    "^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>\n"
    "v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Parse', () {
    Day15Solution solution = Day15Solution();
    solution.parse(bigData);
  });

  test('Part 1 Small', () {
    Day15Solution solution = Day15Solution();
    solution.parse(smallData);
    solution.part1();
    expect(solution.answer1, smallAnswer);
  });

  test('Part 1 Big', () {
    Day15Solution solution = Day15Solution();
    solution.parse(bigData);
    solution.part1();
    expect(solution.answer1, bigAnswer);
  });

  test('Part 2', () {
    Day15Solution solution = Day15Solution();
    solution.parse(bigData);
    solution.part2();
    expect(solution.answer2, 'ran 2');
  });
}
