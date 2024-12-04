import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

final SharedPreferencesAsync prefs = SharedPreferencesAsync();

Future<String?> fetchPuzzleData(int year, int day) async {
  // Check for cached data
  var data = await prefs.getString('$year$day');

  if (data == null) {
    // If not present, get it
    dev.log("Retrieving data from the internet.");
    var cookie = await prefs.getString('session');
    Map<String, String> headers = {};
    headers['Cookie'] = cookie ?? '';
    var response = await http.get(
        Uri.parse('https://adventofcode.com/$year/day/$day/input'),
        headers: headers);
    // Save data in cache if successful
    if (response.statusCode == 200) {
      dev.log("Updating cache.");
      data = response.body;
      await prefs.setString('$year$day', data);
    } else {
      dev.log("Error retrieving data.");
    }
  } else {
    dev.log("Data retrieved from cache.");
  }
  return data;
}

Future<String?> fetchPuzzle(int year, int day) async {
  // Check for cached data
  var data = await prefs.getString('$year${day}_puzzle');

  if (data == null) {
    // If not present, get it
    dev.log("Retrieving data from the internet.");
    var cookie = await prefs.getString('session');
    Map<String, String> headers = {};
    headers['Cookie'] = cookie ?? '';
    var response = await http.get(
        Uri.parse('https://adventofcode.com/$year/day/$day'),
        headers: headers);
    // Save data in cache if successful
    if (response.statusCode == 200) {
      dev.log("Updating cache.");
      data = response.body;
      await prefs.setString('$year${day}_puzzle', data);
    } else {
      dev.log("Error retrieving data.");
    }
  } else {
    dev.log("Data retrieved from cache.");
  }
  return data;
}

Future<void> erasePuzzleData(int year, int day) async {
  await prefs.remove('$year$day');
}

Future<void> erasePuzzle(int year, int day) async {
  await prefs.remove('$year${day}_puzzle');
  dev.log("Puzzle cleared");
}
