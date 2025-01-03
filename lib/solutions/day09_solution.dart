import 'dart:collection';
import 'package:adventofcode2024/mixins/solution.dart';

class Day09Solution with Solution {
  Queue<(int, int, String)> initialFiles = Queue();
  List<(int, int)> initialFreeSpace = [];
  List<String> puzzleData = [];

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    puzzleData = [];
    initialFreeSpace.clear();
    initialFiles.clear();

    int fileId = 0;
    int index = 0;
    for (int i = 0; i < lines[0].length; i++) {
      var space = int.parse(lines[0][i]);
      var fill = '$fileId';
      if (i % 2 == 1) {
        fill = '.';
        initialFreeSpace.add((index, space));
      } else {
        if (space > 0) {
          initialFiles.add((index, space, '$fileId'));
          fileId++;
        }
      }
      for (int j = 0; j < space; j++) {
        puzzleData.add(fill);
      }
      index += space;
    }
    dataIsValid = true;
  }

  int checksum(List<String> disk) {
    int sum = 0;
    for (int i = 0; i < disk.length; i++) {
      if (disk[i] == '.') {
        continue;
      }
      sum += int.parse(disk[i]) * i;
    }
    return sum;
  }

  @override
  void part1() {
    var puzzle = List<String>.from(puzzleData);
    Queue<int> empties = Queue();
    // Determine used block count
    int usedBlockCount = 0;
    for (int i = 0; i < puzzle.length; i++) {
      if (puzzle[i] != '.') {
        usedBlockCount++;
      }
    }
    // Add empty spaces up to usedBlockCount
    for (int i = 0; i < usedBlockCount; i++) {
      if (puzzle[i] == '.') {
        empties.add(i);
      }
    }

    // Move data
    for (int i = puzzle.length - 1; i >= usedBlockCount; i--) {
      if (puzzle[i] == '.') {
        continue;
      }
      puzzle[empties.first] = puzzle[i];
      puzzle[i] = '.';
      empties.removeFirst();
    }

    answer1 = '${checksum(puzzle)}';
  }

  @override
  void part2() {
    var puzzle = List<String>.from(puzzleData);
    var freeSpace = List<(int, int)>.from(initialFreeSpace);
    var files = Queue<(int, int, String)>.from(initialFiles);

    while (files.isNotEmpty) {
      var fStart = files.last.$1;
      var fLength = files.last.$2;
      var fileId = files.last.$3;

      for (int j = 0; j < freeSpace.length; j++) {
        var start = freeSpace[j].$1;
        var length = freeSpace[j].$2;

        if (fStart > start && fLength <= length) {
          for (int i = start; i < start + fLength; i++) {
            puzzle[i] = fileId;
          }
          for (int i = fStart; i < fStart + fLength; i++) {
            puzzle[i] = '.';
          }
          length = length - fLength;
          if (length > 0) {
            start = start + fLength;
          }
          freeSpace[j] = (start, length);
          break;
        }
      }
      files.removeLast();
    }

    answer2 = '${checksum(puzzle)}';
  }

  @override
  int get day => 9;

  @override
  int get year => 2024;
}
