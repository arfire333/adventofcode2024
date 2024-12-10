import 'dart:developer' as dev;
import 'package:adventofcode2024/data.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

Future<String?> getPuzzleDataFromInternet(int year, int day) async {
  dev.log("Retrieving puzzle data from the internet.");

  var cookie = await prefs.getString('session');
  Map<String, String> headers = {};
  headers['Cookie'] = cookie ?? '';

  var response = await http.get(
      Uri.parse('https://adventofcode.com/$year/day/$day/input'),
      headers: headers);

  if (response.statusCode == 200) {
    return response.body;
  }

  dev.log("Error retrieving puzzle data.");
  return null;
}

Future<String?> getPuzzleTextFromInternet(int year, int day) async {
  dev.log("Retrieving puzzle text from the internet.");

  var cookie = await prefs.getString('session');
  Map<String, String> headers = {};
  headers['Cookie'] = cookie ?? '';

  var response = await http.get(
      Uri.parse('https://adventofcode.com/$year/day/$day'),
      headers: headers);

  if (response.statusCode == 200) {
    return html.parse(response.body).body?.querySelector('main')?.text ?? '';
  }

  dev.log("Error retrieving puzzle text.");
  return null;
}
