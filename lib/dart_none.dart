import 'dart:developer' as dev;
import 'package:adventofcode2024/data.dart';

Future<String?> fetchPuzzleData(int year, int day) async {
  // Check for cached data
  var data = await prefs.getString('$year$day');

  if (data == null) {
    // If not present, get it
    dev.log("Retrieving data from the internet.");
  } else {
    dev.log("Data retrieved from cache.");
  }
  data = "3   4\n"
      "4   3\n"
      "2   5\n"
      "1   3\n"
      "3   9\n"
      "3   3\n";
  return data;
}

Future<String?> fetchPuzzle(int year, int day) async {
  // Check for cached data
  var data = await prefs.getString('$year${day}_puzzle');

  if (data == null) {
    // If not present, get it
    dev.log("Retrieving data from the internet.");
  } else {
    dev.log("Data retrieved from cache.");
  }
  data = "3   4\n"
      "4   3\n"
      "2   5\n"
      "1   3\n"
      "3   9\n"
      "3   3\n";
  return data;
}
