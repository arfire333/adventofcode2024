import 'dart:io';

import 'package:adventofcode2024/mixins/solution.dart';

class Point {
  int r;
  int c;

  Point(this.r, this.c);

  // returns true if position is within the board
  bool isValid(List<List<String>> board) {
    if (r < 0 || c < 0 || r >= board.length || c >= board[0].length) {
      return false;
    }

    return true;
  }
}

class Day15Solution with Solution {
  List<List<String>> originalBoard = [];
  List<List<String>> board = [];
  List<List<String>> wideBoard = [];

  List<(int, int)> movements = [];
  List<String> movementsChar = [];

  Point originalRobot = Point(0, 0);
  Point robot = Point(0, 0);
  Point wideRobot = Point(0, 0);
  int currentMove = 0;

  bool isSafe(Point p) {
    if (p.r < 0 ||
        p.c < 0 ||
        p.r >= originalBoard.length ||
        p.c >= originalBoard[0].length) {
      return false;
    }

    return true;
  }

  void reset() {
    robot = Point(originalRobot.r, originalRobot.c);
    wideRobot = Point(originalRobot.r, originalRobot.c);
    board = [];
    wideBoard = [];
    for (int r = 0; r < originalBoard.length; r++) {
      List<String> line = [];
      List<String> wideLine = [];
      for (int c = 0; c < originalBoard[r].length; c++) {
        String oleft = originalBoard[r][c];
        String left = originalBoard[r][c];
        String right = '.';
        if (left == '@') {
          oleft = '.';
          left = '.';
          right = '.';
          wideRobot.r = r;
          wideRobot.c = c * 2;
        } else if (left == '#') {
          right = '#';
        } else if (left == 'O') {
          left = '[';
          right = ']';
        }
        line.add(oleft);
        wideLine.add(left);
        wideLine.add(right);
      }
      board.add(line);
      wideBoard.add(wideLine);
    }
    currentMove = 0;
  }

  @override
  int get year => 2024;

  @override
  int get day => 15;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    originalBoard = [];
    movements = [];
    bool parsingBoard = true;
    const Map<String, (int, int)> moveParser = {
      'v': (1, 0),
      '^': (-1, 0),
      '>': (0, 1),
      '<': (0, -1)
    };
    for (int r = 0; r < lines.length; r++) {
      if (lines[r].isEmpty) {
        parsingBoard = false;
        continue;
      }
      if (parsingBoard) {
        for (int c = 0; c < lines[r].length; c++) {
          if (lines[r][c] == '@') {
            originalRobot = Point(r, c);
          }
        }
        originalBoard.add(lines[r].split(''));
      } else {
        for (int c = 0; c < lines[r].length; c++) {
          movements.add(moveParser[lines[r][c]]!);
          movementsChar.add(lines[r][c]);
        }
      }
    }

    dataIsValid = true;
  }

  bool move(int r, int c, int dr, int dc) {
    if (board[r][c] == '.') {
      return true;
    }
    if (board[r][c] == '#') {
      return false;
    }

    int nr = r + dr;
    int nc = c + dc;

    bool result = move(r + dr, c + dc, dr, dc);
    if (result) {
      board[nr][nc] = board[r][c];
      board[r][c] = '.';
    }
    return result;
  }

  void printBoard() {
    for (int r = 0; r < board.length; r++) {
      for (int c = 0; c < board[0].length; c++) {
        stdout.write(board[r][c]);
      }
      stdout.write('\n');
    }
    stdout.write('\n');
  }

  void printWideBoard({String char = '@'}) {
    for (int r = 0; r < wideBoard.length; r++) {
      for (int c = 0; c < wideBoard[0].length; c++) {
        if ((r == wideRobot.r && c == wideRobot.c)) {
          stdout.write(char);
        } else {
          stdout.write(wideBoard[r][c]);
        }
      }
      stdout.write('\n');
    }
    stdout.write('\n');
  }

  bool moveWide(
      int r, int c, int dr, int dc, Map<(int, int), String> newState) {
    List<int> notClear = [];
    if (wideBoard[r][c] == '#' || wideBoard[r][c + 1] == '#') {
      return false;
    }
    if (dr != 0) {
      for (int ac = -1; ac < 2; ac++) {
        if (wideBoard[r][c + ac] == '[') {
          notClear.add(c + ac);
        }
      }
      if (notClear.isEmpty) {
        return true;
      }
    } else if (dc < 0) {
      if (wideBoard[r][c] == '.') {
        return true;
      } else if (wideBoard[r][c] == ']') {
        return moveWide(r, c - 1, dr, dc, newState);
      }
    } else if (dc > 0) {
      if (wideBoard[r][c + 2] == '.') {
        newState[(r, c + 1)] = '[';
        newState[(r, c + 2)] = ']';
        if (!newState.containsKey((r, c))) {
          newState[(r, c)] = '.';
        }

        return true;
      } else if (wideBoard[r][c] == ']') {
        return moveWide(r, c + 1, dr, dc, newState);
      }
    }

    bool result = true;
    if (dr != 0) {
      // move up/down
      int nr = r + dr;
      for (var nc in notClear) {
        result &= moveWide(nr, nc, dr, dc, newState);
      }
      if (result) {
        for (var nc in notClear) {
          newState[(nr, nc)] = '[';
          newState[(nr, nc + 1)] = ']';
          if (!newState.containsKey((r, nc))) {
            newState[(r, nc)] = '.';
          }
          if (!newState.containsKey((r, nc + 1))) {
            newState[(r, nc + 1)] = '.';
          }
        }
      }
    } else if (dc < 0) {
      // move left
      int nc = c + dc;
      result = moveWide(r, nc, dr, dc, newState);
      if (result) {
        newState[(r, nc)] = '[';
        newState[(r, nc + 1)] = ']';
        if (!newState.containsKey((r, nc + 2))) {
          newState[(r, nc + 2)] = '.';
        }
      }
    } else if (dc > 0) {
      // move right
      int nc = c + dc;
      result = moveWide(r, nc, dr, dc, newState);
      if (result) {
        newState[(r, nc)] = '[';
        newState[(r, nc + 1)] = ']';
        if (!newState.containsKey((r, c))) {
          newState[(r, c)] = '.';
        }
      }
    }

    return result;
  }

  @override
  void part1() {
    reset();
    // Perform movements
    for (int i = 0; i < movements.length; i++) {
      if (move(robot.r + movements[i].$1, robot.c + movements[i].$2,
          movements[i].$1, movements[i].$2)) {
        robot.r += movements[i].$1;
        robot.c += movements[i].$2;
      }
    }
    // Calc sums
    int sum = 0;
    for (int r = 0; r < board.length; r++) {
      for (int c = 0; c < board[0].length; c++) {
        if (board[r][c] == 'O') {
          sum += r * 100 + c;
        }
      }
    }
    answer1 = '$sum';
  }

  @override
  void part2() {
    reset();
    // printWideBoard();
    // Perform movements
    for (int i = 0; i < movements.length; i++) {
      // stdout.write('$i: ${movementsChar[i]}\n');
      int nextRowToCheck = wideRobot.r + movements[i].$1;
      int nextColToCheck = wideRobot.c + movements[i].$2;
      if (wideBoard[nextRowToCheck][nextColToCheck] == '.') {
        wideRobot.r += movements[i].$1;
        wideRobot.c += movements[i].$2;
        // printWideBoard(char: movementsChar[i]);
        continue;
      }
      if (wideBoard[nextRowToCheck][nextColToCheck] == ']') {
        nextColToCheck -= 1;
      }
      Map<(int, int), String> nextState = {};
      if (moveWide(nextRowToCheck, nextColToCheck, movements[i].$1,
          movements[i].$2, nextState)) {
        wideRobot.r += movements[i].$1;
        wideRobot.c += movements[i].$2;
        for (var val in nextState.entries) {
          wideBoard[val.key.$1][val.key.$2] = val.value;
        }
      }
      // printWideBoard(char: movementsChar[i]);
      continue;
    }
    // printWideBoard();
    // Calc sums
    int sum = 0;
    for (int r = 0; r < wideBoard.length; r++) {
      for (int c = 0; c < wideBoard[0].length; c++) {
        if (wideBoard[r][c] == '[') {
          sum += r * 100 + c;
        }
      }
    }
    answer2 = '$sum';
  }

  void step() {
    int i = currentMove;
    if (movements.isEmpty) {
      return;
    }
    int nextRowToCheck = wideRobot.r + movements[i].$1;
    int nextColToCheck = wideRobot.c + movements[i].$2;
    if (wideBoard[nextRowToCheck][nextColToCheck] == '.') {
      wideRobot.r += movements[i].$1;
      wideRobot.c += movements[i].$2;
      // printWideBoard(char: movementsChar[i]);
    } else {
      if (wideBoard[nextRowToCheck][nextColToCheck] == ']') {
        nextColToCheck -= 1;
      }
      Map<(int, int), String> nextState = {};
      if (moveWide(nextRowToCheck, nextColToCheck, movements[i].$1,
          movements[i].$2, nextState)) {
        wideRobot.r += movements[i].$1;
        wideRobot.c += movements[i].$2;
        for (var val in nextState.entries) {
          wideBoard[val.key.$1][val.key.$2] = val.value;
        }
      }
    }
    currentMove++;
    if (currentMove >= movements.length) {
      currentMove = 0;
      reset();
    }
  }
}
