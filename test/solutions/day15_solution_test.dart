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

String small2Data = "#######\n"
    "#...#.#\n"
    "#.....#\n"
    "#..OO@#\n"
    "#..O..#\n"
    "#.....#\n"
    "#######\n"
    "\n"
    "<vv<<^^<<^^\n";

String small2Answer = '618';

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
    Day15Solution s = Day15Solution();
    s.parse(bigData);
    expect(s.originalBoard.length, 10);
    expect(s.originalBoard[0].length, 10);
    expect(s.movements.length, 700);
    expect(s.originalRobot.r, 4);
    expect(s.originalRobot.c, 4);
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

  test('Part 2 Small', () {
    Day15Solution solution = Day15Solution();
    solution.parse(small2Data);
    solution.reset();
    solution.part2();
    expect(solution.answer2, small2Answer);
  });
  test('Part 2', () {
    Day15Solution solution = Day15Solution();
    solution.parse(bigData);
    solution.reset();
    solution.part2();
    expect(solution.answer2, '9021');
    // 778529 to low
    // 1542149 to high
    // 1549442
  });
  test('Part 2 Test Error', () {
    Day15Solution solution = Day15Solution();
    solution.parse(testError);
    solution.reset();
    solution.part2();
    expect(solution.answer2, testAnswer);
  });
}

String testError = "#######\n"
    "#..O..#\n"
    "#.#.O@#\n"
    "#...O.#\n"
    "#..OOO#\n"
    "#..O#.#\n"
    "#..O..#\n"
    "#.....#\n"
    "#..#..#\n"
    "#######\n"
    "\n"
    "v<>^<<v\n";

String testAnswer = '2955';
