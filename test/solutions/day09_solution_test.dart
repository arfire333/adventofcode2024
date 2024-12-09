// tree, read text, and verify that the values of widget properties are correct.

import 'package:adventofcode2024/solutions/day09_solution.dart';
import 'package:flutter_test/flutter_test.dart';

String rawData = "2333133121414131402\n";

void main() async {
  test('Parse', () {
    Day09Solution solution = Day09Solution();
    solution.parse('212');
    expect(solution.puzzleData, ['0', '0', '.', '1', '1']);
    expect(solution.initialFiles.first, (0, 2, '0'));
    expect(solution.initialFiles.last, (3, 2, '1'));
    expect(solution.initialFreeSpace.last, (2, 1));
  });
  test('Part 1', () {
    Day09Solution solution = Day09Solution();
    solution.parse(rawData);
    solution.part1();
    expect(solution.answer1, '1928');
  });

  test('Part 2', () {
    Day09Solution solution = Day09Solution();
    solution.parse(rawData);
    solution.part2();
    solution.part2();
    expect(solution.answer2, '2858');
    // 8570102309998 To high
  });
  test('Part 2 Trouble', () {
    Day09Solution solution = Day09Solution();
    String data = "22122";
    var parsed = ['0', '0', '.', '.', '1', '.', '.', '2', '2'];
    solution.parse(data);
    expect(solution.puzzleData, parsed);
    solution.part2();
    solution.part2();
    expect(solution.answer2, '14');
    // 8570102309998 To high
    // 8569884438850 To High
  });
  test('Part 2 Trouble2', () {
    Day09Solution solution = Day09Solution();
    String data = "02122";
    var parsed = ['.', '.', '0', '.', '.', '1', '1'];
    solution.parse(data);
    expect(solution.puzzleData, parsed);
    solution.part2();
    solution.part2();
    expect(solution.answer2, '1');
  });

  test('Checksum', () {
    Day09Solution solution = Day09Solution();
    solution.parse(rawData);

    List<String> part1 = [
      // Prevent reformatting
      '0', '0', '9', '9', '8', '1', '1', '1', '8', '8', '8', '2', '7', '7',
      '7', '3', '3', '3', '6', '4', '4', '6', '5', '5', '5', '5', '6', '6',
      '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    ];
    expect(solution.checksum(part1), 1928);
    var part2 = [
      // Prevent reformatting
      '0', '0', '9', '9', '2', '1', '1', '1', '7', '7', '7', '.', '4', '4',
      '.', '3', '3', '3', '.', '.', '.', '.', '5', '5', '5', '5', '.', '6',
      '6', '6', '6', '.', '.', '.', '.', '.', '8', '8', '8', '8', '.', '.'
    ];
    expect(solution.checksum(part2), 2858);
  });
}
