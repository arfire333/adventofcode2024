export 'package:adventofcode2024/dart_none.dart'
    if (dart.library.io) 'package:adventofcode2024/dart_io.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

final SharedPreferencesAsync prefs = SharedPreferencesAsync();

Future<void> erasePuzzleData(int year, int day) async {
  await prefs.remove('$year$day');
}

Future<void> erasePuzzle(int year, int day) async {
  await prefs.remove('$year${day}_puzzle');
  dev.log("Puzzle cleared");
}

void printPuzzle<T>(List<List<T>> p) {
  stdout.write(r'\ ');
  for (int i = 0; i < p[0].length; i++) {
    stdout.write('${i % 10} ');
  }
  stdout.write('\n');
  for (int r = 0; r < p.length; r++) {
    stdout.write('${r % 10} ');
    for (var col in p[r]) {
      stdout.write('$col ');
    }
    stdout.write('\n');
  }
}
