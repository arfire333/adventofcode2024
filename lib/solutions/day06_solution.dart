import 'dart:io';
import 'package:adventofcode2024/mixins/solution.dart';
import 'dart:developer' as dev;

class Guard {
  Pair pos = Pair(0, 0);
  String head = '.';

  Guard(this.pos, this.head);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Guard && pos == other.pos && head == other.head;
  }

  @override
  int get hashCode => (pos.hashCode << 31) ^ head.hashCode;

  @override
  String toString() => 'DirectedPosition(position: $pos, heading: $head)';
}

final Map<String, Pair> possibleDeltas = {
  '^': Pair(-1, 0),
  '>': Pair(0, 1),
  'v': Pair(1, 0),
  '<': Pair(0, -1)
};

class Day06Solution with Solution {
  Guard guard = Guard(Pair(0, 0), '.');
  Guard initialGuardPosition = Guard(Pair(0, 0), '.');
  Set<Guard> visitedPlus = {};
  Set<Pair> visitedPositions = {};
  Set<Pair> possibleBarriers = {};
  List<String> board = [];
  List<List<String>> modifiedBoard = [];

  @override
  void parse(String rawData) {
    // Don't forget to clear data
    var lines = rawData.split('\n');
    // Parse lines
    int row = 0;
    board.clear();

    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      board.add(line);
      if (guard.head == '.') {
        for (int col = 0; col < line.length; col++) {
          if (line[col] != '.' && line[col] != '#') {
            initialGuardPosition.pos = Pair(row, col);
            initialGuardPosition.head = line[col];
            break;
          }
        }
        row++;
      }
    }

    dataIsValid = true;
  }

  /// Return the next position assuming one time step
  Guard move(Guard current) {
    var nextHeading = current.head;
    var nextPosition = current.pos + possibleDeltas[nextHeading]!;
    int count = 0;
    if (nextPosition.r < 0 ||
        nextPosition.r >= board.length ||
        nextPosition.c < 0 ||
        nextPosition.c >= board[0].length) {
      return Guard(nextPosition, nextHeading);
    }
    while (board[nextPosition.r][nextPosition.c] == '#') {
      nextHeading = rotateHeading(current.head);
      nextPosition = current.pos + possibleDeltas[nextHeading]!;
      count++;
      if (count >= 4) {
        dev.log("No place to move to.");
        return Guard(current.pos, current.head);
      }
      if (nextPosition.r < 0 ||
          nextPosition.r >= board.length ||
          nextPosition.c < 0 ||
          nextPosition.c >= board[0].length) {
        return Guard(nextPosition, nextHeading);
      }
    }
    return Guard(nextPosition, nextHeading);
  }

  bool isBarrier(Pair position) {
    if (board[position.r][position.c] == '#') {
      return true;
    }
    return false;
  }

  @override
  void part1() {
    guard = Guard(initialGuardPosition.pos, initialGuardPosition.head);
    visitedPositions.clear();
    visitedPlus.clear();

    while (!visitedPlus.contains(guard)) {
      visitedPlus.add(guard);
      visitedPositions.add(guard.pos);
      guard = move(guard);
      if (guard.pos.r < 0 ||
          guard.pos.r >= board.length ||
          guard.pos.c < 0 ||
          guard.pos.c >= board[0].length) {
        break;
      }
    }

    answer1 = '${visitedPositions.length}';
  }

  @override
  void part2() {
    Set<Pair> newBarriers = {};
    modifiedBoard = [];
    for (var line in board) {
      if (line.isEmpty) {
        continue;
      }
      modifiedBoard.add(line.split(''));
    }
    int checked = 0;
    for (var pos in visitedPositions) {
      // Setup board
      int r = pos.r;
      int c = pos.c;
      if (modifiedBoard[r][c].compareTo('^') == 0 ||
          modifiedBoard[r][c].compareTo('#') == 0 ||
          (r == initialGuardPosition.pos.r &&
              c == initialGuardPosition.pos.c)) {
        continue;
      }
      var barrier = Pair(r, c);
      checked++;
      dev.log(
          'Testing $checked of ${visitedPositions.length} possible barrier locations.');

      modifiedBoard[barrier.r][barrier.c] = '#';

      // Set guard starting position
      var localguard =
          Guard(initialGuardPosition.pos, initialGuardPosition.head);

      // keep track of visited locations
      Set<Guard> visited = {};
      // If we have visited in this orientation,
      // we have a cycle
      bool reachedBorder = false;
      while (!visited.contains(localguard)) {
        visited.add(localguard);
        localguard = move2(localguard, modifiedBoard);
        if (localguard.pos.r < 0 ||
            localguard.pos.r >= modifiedBoard.length ||
            localguard.pos.c < 0 ||
            localguard.pos.c >= modifiedBoard[0].length) {
          reachedBorder = true;
          break;
        }
      }
      if (visited.contains(localguard) && !reachedBorder) {
        newBarriers.add(barrier);
      }
      modifiedBoard[barrier.r][barrier.c] = '.';
    }

    dev.log('$newBarriers');
    answer2 = '${newBarriers.length}';
  }

  void logPath() {
    stdout.write(r'\ ');
    for (var c = 0; c < modifiedBoard[0].length; c++) {
      stdout.write('${c % 10} ');
    }
    stdout.write('\n');
    for (var r = 0; r < modifiedBoard.length; r++) {
      stdout.write('${r % 10} ');
      for (var c = 0; c < modifiedBoard[0].length; c++) {
        var val = modifiedBoard[r][c];
        stdout.write('$val ');
      }
      stdout.write('\n');
    }
  }

  @override
  int get day => 6;

  @override
  int get year => 2024;
}

void printBoard(List<List<String>> board) {
  stdout.write(r'\ ');
  for (var c = 0; c < board[0].length; c++) {
    stdout.write('${c % 10} ');
  }
  stdout.write('\n');
  for (var r = 0; r < board.length; r++) {
    stdout.write('${r % 10} ');
    for (var c = 0; c < board[0].length; c++) {
      var val = board[r][c];
      stdout.write('$val ');
    }
    stdout.write('\n');
  }
}

Guard move2(Guard current, List<List<String>> board) {
  var nextHeading = current.head;
  var nextPosition = current.pos + possibleDeltas[nextHeading]!;
  int count = 0;
  if (nextPosition.r < 0 ||
      nextPosition.r >= board.length ||
      nextPosition.c < 0 ||
      nextPosition.c >= board[0].length) {
    return Guard(nextPosition, nextHeading);
  }
  while (board[nextPosition.r][nextPosition.c].compareTo('#') == 0) {
    nextHeading = rotateHeading(nextHeading);
    nextPosition = current.pos + possibleDeltas[nextHeading]!;
    count++;
    if (count >= 4) {
      dev.log("No place to move to.");
      return Guard(current.pos, current.head);
    }
    if (nextPosition.r < 0 ||
        nextPosition.r >= board.length ||
        nextPosition.c < 0 ||
        nextPosition.c >= board[0].length) {
      return Guard(nextPosition, nextHeading);
    }
  }
  return Guard(nextPosition, nextHeading);
}

String rotateHeading(String heading) {
  switch (heading) {
    case '^':
      return '>';
    case '>':
      return 'v';
    case 'v':
      return '<';
    case '<':
      return '^';
    default:
      return 'x';
  }
}

class Pair {
  int r = 0;
  int c = 0;
  Pair(this.r, this.c);

  Pair operator +(Pair other) {
    return Pair(r + other.r, c + other.c);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Pair && r == other.r && c == other.c;
  }

  @override
  int get hashCode => r.hashCode ^ c.hashCode;

  @override
  String toString() => 'Pair(r: $r, c: $c)';
}
