export 'package:adventofcode2024/dart_none.dart'
    if (dart.library.io) 'package:adventofcode2024/dart_io.dart';
import 'dart:io';

import 'package:flutter/material.dart';
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

Future<String?> getManualData(int year, int day, context) async {
  String? rawData;
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController inputController = TextEditingController();
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;

        return AlertDialog(
            content: Column(
          children: [
            const Text('Please paste your puzzle input.'),
            Padding(
              padding: const EdgeInsets.all(7),
              child: SizedBox(
                width: width,
                height: 0.7 * height,
                child: SingleChildScrollView(
                  child: TextFormField(
                    controller: inputController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onFieldSubmitted: (newValue) {
                      rawData = newValue;
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: ElevatedButton(
                  onPressed: () {
                    rawData = inputController.text;
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ),
          ],
        ));
      });
  return rawData;
}
