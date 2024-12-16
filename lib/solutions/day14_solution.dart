import 'package:adventofcode2024/mixins/solution.dart';

class Robot {
  int x;
  int y;
  int vx;
  int vy;

  Robot(this.x, this.y, this.vx, this.vy);
}

class Day14Solution with Solution {
  List<Robot> initialRobotsPosition = [];
  List<Robot> robots = [];
  List<int> rCount = List<int>.filled(103, 0);
  List<int> cCount = List<int>.filled(101, 0);
  int h = 103;
  int w = 101;
  // int h = 11;
  // int w = 7;

  @override
  int get year => 2024;

  @override
  int get day => 14;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    robots = [];
    initialRobotsPosition = [];
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      var r = line.split(' ');
      var p = r[0].split('=')[1].split(',');
      var v = r[1].split('=')[1].split(',');

      robots.add(Robot(
        int.parse(p[0]),
        int.parse(p[1]),
        int.parse(v[0]),
        int.parse(v[1]),
      ));
      initialRobotsPosition.add(Robot(
        int.parse(p[0]),
        int.parse(p[1]),
        int.parse(v[0]),
        int.parse(v[1]),
      ));
    }

    dataIsValid = true;
  }

  void step() {
    for (var robot in robots) {
      int nx = robot.x + robot.vx;
      int ny = robot.y + robot.vy;
      if (nx < 0) {
        nx += w;
      }
      if (ny < 0) {
        ny += h;
      }
      nx = nx % w;
      ny = ny % h;
      robot.x = nx;
      robot.y = ny;
    }
  }

  (int, int, int, int) quadrantCount() {
    int q1 = 0;
    int q2 = 0;
    int q3 = 0;
    int q4 = 0;
    int xb = w ~/ 2;
    int yb = h ~/ 2;
    for (var robot in robots) {
      int x = robot.x;
      int y = robot.y;

      if (x < xb && y < yb) {
        q1++;
      } else if (x > xb && y < yb) {
        q2++;
      } else if (x < xb && y > yb) {
        q3++;
      } else if (x > xb && y > yb) {
        q4++;
      }
    }
    return (q1, q2, q3, q4);
  }

  void resetData() {
    robots = [];
    for (var r in initialRobotsPosition) {
      robots.add(Robot(r.x, r.y, r.vx, r.vy));
    }
  }

  @override
  void part1() {
    for (int i = 0; i < 100; i++) {
      step();
    }
    var (q1, q2, q3, q4) = quadrantCount();
    answer1 = '${q1 * q2 * q3 * q4}';
  }

  (double, double, double, double) stats() {
    double xmean = 0;
    double ymean = 0;
    for (var r in robots) {
      xmean += r.x;
      ymean += r.y;
    }
    xmean = xmean / robots.length;
    ymean = ymean / robots.length;

    double xvar = 0;
    double yvar = 0;
    for (var r in robots) {
      xvar += (r.x - xmean) * (r.x - xmean);
      yvar += (r.y - ymean) * (r.y - xmean);
    }
    xvar = xvar / robots.length;
    yvar = yvar / robots.length;
    return (xmean, ymean, xvar, yvar);
  }

  @override
  void part2() {
    bool treeNotFound = true;
    int count = 0;
    while (treeNotFound) {
      step();
      count++;
      var (xm, ym, xv, yv) = stats();
      if (xv < 350 && yv < 350) {
        break;
      }
    }
    answer2 = '$count';
  }
}
