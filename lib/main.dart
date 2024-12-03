import 'package:adventofcode2024/pages/day_01.dart';
import 'package:adventofcode2024/pages/day_02.dart';
import 'package:adventofcode2024/pages/day_03.dart';
import 'package:adventofcode2024/pages/settings.dart';
import 'package:adventofcode2024/pages/template.dart';
import 'package:adventofcode2024/common.dart' as strings;
import 'package:flutter/material.dart';
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
      ),
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

  Widget _panel = const TemplateWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: inversePrimary,
          title: Row(children: [
            ImageIcon(strings.elfImage.image),
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
        ListTile(
          title: const Text('Day 1'),
          onTap: () {
            setState(() => _panel = const Day01Widget());
            Navigator.pop(context);
          },
        ),
        ListTile(
            title: const Text('Day 2'),
            onTap: () {
              setState(() => _panel = const Day02Widget());
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Day 3'),
            onTap: () {
              setState(() => _panel = const Day03Widget());
              Navigator.pop(context);
            }),
      ])),
      body: Center(child: _panel),
    );
  }
}
