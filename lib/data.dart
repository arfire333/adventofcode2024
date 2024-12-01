import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

final SharedPreferencesAsync prefs = SharedPreferencesAsync();

Future<String> fetchPuzzleData(int year, int day) async {
  // Check for cached data
  var data = await prefs.getString('$year$day');

  if (data == null) {
    // If not present, get it
    dev.log("Cache Miss!");
    var cookie = await prefs.getString('session');
    Map<String, String> headers = {};
    headers['Cookie'] = cookie ?? '';
    var response = await http.get(
        Uri.parse('https://adventofcode.com/$year/day/$day/input'),
        headers: headers);
    data = response.body;
    // Save data in cache
    await prefs.setString('$year$day', data);
  }
  return data;
}
