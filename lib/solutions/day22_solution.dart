import 'package:adventofcode2024/mixins/solution.dart';

class Day22Solution with Solution {
  Map<(int, int, int, int), int> nanas = {};
  List<int> seeds = [];
  @override
  int get year => 2024;

  @override
  int get day => 22;

  @override
  void parse(String rawData) {
    var lines = rawData.split('\n');
    // Don't forget to clear data
    // Parse lines
    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      seeds.add(int.parse(line));
    }

    dataIsValid = true;
  }

  int genNext(int secret) {
    int step1 = ((secret * 64) ^ secret) % 16777216;
    int step2 = ((step1 ~/ 32) ^ step1) % 16777216;
    int step3 = ((step2 * 2048) ^ step2) % 16777216;
    return step3;
  }

  @override
  void part1() {
    int sum = 0;
    for (var secret in seeds) {
      for (int i = 0; i < 2000; i++) {
        secret = genNext(secret);
      }
      sum += secret;
    }

    answer1 = '$sum';
  }

  @override
  void part2() {
    int sum = 0;
    nanas = {};
    for (var secret in seeds) {
      int last = secret;
      int lastPrice = secret % 10;
      Set<(int, int, int, int)> visited = {};
      List<int> deltas = [];
      List<int> price = [];
      for (int i = 0; i < 2000; i++) {
        secret = genNext(last);
        int newPrice = secret % 10;
        deltas.add(newPrice - lastPrice);
        price.add(newPrice);
        last = secret;
        lastPrice = newPrice;
      }
      for (int i = 3; i < deltas.length; i++) {
        int d1 = deltas[i - 3];
        int d2 = deltas[i - 2];
        int d3 = deltas[i - 1];
        int d4 = deltas[i];
        var key = (d1, d2, d3, d4);
        if (visited.contains(key)) {
          continue;
        }
        var last = (nanas[key] ??= 0);
        nanas[key] = last + price[i];
        visited.add(key);
      }
    }
    int mostnanas = 0;
    for (var val in nanas.values) {
      if (val > mostnanas) {
        mostnanas = val;
      }
    }
    sum += mostnanas;

    answer2 = '$sum';
  }
}
