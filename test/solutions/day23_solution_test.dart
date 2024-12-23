import 'package:adventofcode2024/solutions/day23_solution.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

String rawData = "kh-tc\n"
    "qp-kh\n"
    "de-cg\n"
    "ka-co\n"
    "yn-aq\n"
    "qp-ub\n"
    "cg-tb\n"
    "vc-aq\n"
    "tb-ka\n"
    "wh-tc\n"
    "yn-cg\n"
    "kh-ub\n"
    "ta-co\n"
    "de-co\n"
    "tc-td\n"
    "tb-wq\n"
    "wh-td\n"
    "ta-ka\n"
    "td-qp\n"
    "aq-cg\n"
    "wq-ub\n"
    "ub-vc\n"
    "de-ta\n"
    "wq-aq\n"
    "wq-vc\n"
    "wh-yn\n"
    "ka-de\n"
    "kh-ta\n"
    "co-tc\n"
    "wh-qp\n"
    "tb-vc\n"
    "td-yn\n";

void main() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();

  test('Parsing', () {
    Day23Solution s = Day23Solution();
    s.parse(rawData);
    expect(s.nodes.length, 16);
    expect(s.nodeConnections.length, 16);
  });

  test('Part 1', () {
    Day23Solution solution = Day23Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '7');
  });

  test('isValid', () {
    Day23Solution s = Day23Solution();
    s.parse(rawData);
    expect(s.part1ValidSet({"qp", "td", "wh"}), true);
    EqualitySet<Set<String>> set = EqualitySet(const SetEquality());
    Set<String> a = {"qp", "tp"};
    Set<String> b = {"tp", "qp"};

    set.add(a);
    set.add(b);
    expect(set.length, 1);
  });

  test('Part 2', () {
    Day23Solution solution = Day23Solution();
    solution.parse(rawData);
    solution.part2();
    expect(solution.answer2, 'co,de,ka,ta');
  });
}
