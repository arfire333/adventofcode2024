import 'package:adventofcode2024/pages/day_01.dart';
import 'package:adventofcode2024/pages/day_02.dart';
import 'package:adventofcode2024/pages/day_03.dart';
import 'package:adventofcode2024/pages/day_04.dart';
import 'package:adventofcode2024/pages/day_05.dart';
import 'package:adventofcode2024/pages/day_06.dart';
import 'package:adventofcode2024/pages/day_07.dart';
import 'package:adventofcode2024/pages/day_08.dart';
import 'package:adventofcode2024/pages/day_09.dart';
import 'package:adventofcode2024/pages/day_10.dart';
import 'package:adventofcode2024/pages/day_11.dart';
import 'package:adventofcode2024/pages/day_12.dart';
import 'package:adventofcode2024/pages/day_13.dart';
import 'package:adventofcode2024/pages/day_14.dart';
import 'package:adventofcode2024/pages/day_15.dart';
import 'package:adventofcode2024/pages/day_16.dart';
// Add new import here
import 'package:adventofcode2024/pages/settings.dart';
import 'package:adventofcode2024/pages/template.dart';
import 'package:adventofcode2024/common.dart' as strings;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const AOCApp2024());
}

class AOCApp2024 extends StatelessWidget {
  const AOCApp2024({super.key});

  final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(0, 100, 0, 1),
      inversePrimary: Color.fromRGBO(0, 255, 0, 1),
      onPrimary: Colors.white,
      secondary: Color.fromRGBO(100, 0, 0, 1),
      onSecondary: Colors.white,
      error: Colors.black,
      onError: Colors.red,
      surface: Colors.white,
      onSurface: Color.fromRGBO(0, 42, 0, 1));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advent of Code 2024',
      theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          textTheme: GoogleFonts.ubuntuMonoTextTheme()
              .copyWith(bodyMedium: GoogleFonts.ubuntuMono(fontSize: 18))),
      home: const AOCWidget2024(),
    );
  }
}

class AOCWidget2024 extends StatefulWidget {
  const AOCWidget2024({super.key});

  @override
  State<AOCWidget2024> createState() => _AOCWidget2024State();
}

class _AOCWidget2024State extends State<AOCWidget2024> {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  // Widget _panel = const TemplateWidget();
  Widget _panel = const Day13Widget();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dayList = [
      const TemplateWidget(),
      const Day01Widget(),
      const Day02Widget(),
      const Day03Widget(),
      const Day04Widget(),
      const Day05Widget(),
      const Day06Widget(),
      const Day07Widget(),
      const Day08Widget(),
      const Day09Widget(),
      const Day10Widget(),
      const Day11Widget(),
      const Day12Widget(),
      const Day13Widget(),
      const Day14Widget(),
      const Day15Widget(),
      const Day16Widget(),
      // Add new day here
    ];
    final inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: inversePrimary,
          title: Row(children: [
            ImageIcon(
              strings.elfImage.image,
            ),
            const SafeArea(child: Text(strings.appTitle)),
          ])),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
            decoration: BoxDecoration(color: inversePrimary),
            child: const Text(strings.drawerTitle)),
        IconButton(
          icon: ImageIcon(strings.elfImage.image),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Settings();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Template'),
          onTap: () {
            setState(() => _panel = const TemplateWidget());
            Navigator.pop(context);
          },
        ),
        for (var i = 1; i <= dayList.length - 1; i++)
          ListTile(
              title: Text('Day $i'),
              onTap: () {
                setState(() => _panel = dayList[i]);
                Navigator.pop(context);
              }),
      ])),
      body: SafeArea(child: Center(child: _panel)),
    );
  }
}
