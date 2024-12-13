import 'package:adventofcode2024/mixins/solution.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:developer' as dev;

typedef Matrix = List<List<double>>;

class Day13Solution with Solution {
  List<(int, int)> A = [];
  List<(int, int)> B = [];
  List<(int, int)> P = [];

  @override
  int get year => 2024;

  @override
  int get day => 13;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    A = [];
    B = [];
    P = [];
    // Don't forget to clear data
    // Parse lines
    int i = 0;
    while (i < lines.length) {
      var line = lines[i++];
      if (line.isEmpty) {
        continue;
      }
      // A
      var xy = line.split(':')[1].split(',');
      var x = int.parse(xy[0].split('+')[1]);
      var y = int.parse(xy[1].split('+')[1]);
      A.add((x, y));
      // A
      line = lines[i++];
      xy = line.split(':')[1].split(',');
      x = int.parse(xy[0].split('+')[1]);
      y = int.parse(xy[1].split('+')[1]);
      B.add((x, y));
      // A
      line = lines[i++];
      xy = line.split(':')[1].split(',');
      x = int.parse(xy[0].split('=')[1]);
      y = int.parse(xy[1].split('=')[1]);
      P.add((x, y));
    }

    dataIsValid = true;
  }

  @override
  void part1() {
    int sum = 0;
    for (int i = 0; i < A.length; i++) {
      var m = Matrix4.fromList([
        //
        A[i].$1.toDouble(), A[i].$2.toDouble(), 0, 0,
        B[i].$1.toDouble(), B[i].$2.toDouble(), 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      ]);
      var minv = Matrix4.inverted(m);
      Vector4 p = Vector4(P[i].$1.toDouble(), P[i].$2.toDouble(), 0, 0);

      var r = minv * p;

      var a = r[0].round();
      var b = r[1].round();
      if ((a - r[0]).abs() > 0.00001) {
        continue;
      }
      if ((b - r[1]).abs() > 0.00001) {
        continue;
      }
      var cost = 3 * a + b;
      sum += cost.toInt();
    }

    answer1 = '$sum';
  }

  @override
  void part2() {
    int sum = 0;
    for (int i = 0; i < A.length; i++) {
      var m = Matrix4.fromList([
        //
        A[i].$1.toDouble(), A[i].$2.toDouble(), 0, 0,
        B[i].$1.toDouble(), B[i].$2.toDouble(), 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      ]);
      var minv = Matrix4.inverted(m);
      Vector4 p = Vector4(P[i].$1.toDouble() + 10000000000000,
          P[i].$2.toDouble() + 10000000000000, 0, 0);

      var r = minv * p;

      var a = r[0].round();
      var b = r[1].round();
      if ((a - r[0]).abs() > 0.001) {
        dev.log('$i/${A.length}: $a - ${r[0]} = ${(a - r[0]).abs()}');
        dev.log('$i/${A.length}: $a - ${r[1]} = ${(a - r[1]).abs()}');
        continue;
      }
      if ((b - r[1]).abs() > 0.001) {
        dev.log('$i/${A.length}: $a - ${r[0]} = ${(a - r[0]).abs()}');
        dev.log('$i/${A.length}: $a - ${r[1]} = ${(a - r[1]).abs()}');
        continue;
      }
      var cost = 3 * a + b;
      dev.log(
          '$i/${A.length}: 3*$a + $b = $cost  -- ${P[i].$1 + 10000000000000}');
      sum += cost.toInt();
    }

    answer2 = '$sum';
  }
}
