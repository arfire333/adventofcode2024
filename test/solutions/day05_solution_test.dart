import 'package:adventofcode2024/solutions/day05_solution.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "47|53\n"
    "97|13\n"
    "97|61\n"
    "97|47\n"
    "75|29\n"
    "61|13\n"
    "75|53\n"
    "29|13\n"
    "97|29\n"
    "53|29\n"
    "61|53\n"
    "97|53\n"
    "61|29\n"
    "47|13\n"
    "75|47\n"
    "97|75\n"
    "47|61\n"
    "75|61\n"
    "47|29\n"
    "75|13\n"
    "53|13\n"
    "\n"
    "75,47,61,53,29\n"
    "97,61,53,29,13\n"
    "75,29,13\n"
    "75,97,47,61,53\n"
    "61,13,29\n"
    "97,13,75,29,47\n";

void main() async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  test('Part 1', () async {
    Day05Solution solution = Day05Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '143');
  });

  test('Part 2', () async {
    Day05Solution solution = Day05Solution();
    solution.parse(rawData);
    // To get the list of bad updates, run part 1.
    solution.part1();
    solution.part2();
    expect(solution.answer2, '123');
  });
}
