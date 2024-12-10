import 'package:adventofcode2024/data.dart' as puzzle_data;
import 'package:shared_preferences/shared_preferences.dart';

mixin Solution {
  int get year;
  int get day;

  bool dataIsValid = false;

  String puzzleText = '';

  String answer1 = 'TBD';
  String answer2 = 'TBD';

  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  // Gets and parses data then returns true on success
  Future<bool> getPuzzleData(context) async {
    bool dataCacheHit = true;
    var rawData = await prefs.getString('$year$day') ?? '';

    if (rawData.isEmpty) {
      rawData = await puzzle_data.getPuzzleDataFromInternet(year, day) ?? '';
      dataCacheHit = false;
    }

    if (rawData.isEmpty) {
      rawData = await puzzle_data.getManualData(year, day, context) ?? '';
      dataCacheHit = false;
    }

    if (!dataCacheHit && rawData.isNotEmpty) {
      SharedPreferencesAsync().setString('$year$day', rawData);
    }

    if (rawData.isNotEmpty) {
      parse(rawData);
      return true;
    }
    return false;
  }

  Future<bool> getPuzzleText() async {
    bool textCacheHit = true;
    var rawData = await prefs.getString('$year$day') ?? '';
    puzzleText = await prefs.getString('$year${day}_puzzle') ?? '';

    if (puzzleText.isEmpty) {
      puzzleText = await puzzle_data.getPuzzleTextFromInternet(year, day) ?? '';
      textCacheHit = false;
    }

    if (puzzleText.isEmpty && rawData.isNotEmpty) {
      puzzleText = rawData;
      textCacheHit = true; // Don't update cache for text if it's not the text.
    }

    if (!textCacheHit && puzzleText.isNotEmpty) {
      SharedPreferencesAsync().setString('$year${day}_puzzle', puzzleText);
    }

    if (puzzleText.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> erasePuzzleData() async {
    await prefs.remove('$year$day');
    answer1 = 'TBD';
    answer2 = 'TBD';
  }

  Future<void> erasePuzzleText() async {
    await prefs.remove('$year${day}_puzzle');
    puzzleText = '';
  }

  void parse(String rawData);

  void part1();

  void part2();
}
