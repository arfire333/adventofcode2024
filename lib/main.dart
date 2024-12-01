import 'package:adventofcode2024/pages/settings.dart';
import 'package:adventofcode2024/strings.dart' as strings;
import 'package:adventofcode2024/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adventofcode2024/data.dart' as puzzle_data;

void main() {
  runApp(const AOCApp2024());
}

class AOCApp2024 extends StatelessWidget {
  const AOCApp2024({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advent of Code 2024',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
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
  String _data = '';

  Future<void> fetchData(int year, int day) async {
    var data = await puzzle_data.fetchPuzzleData(2023, 1);

    setState(() {
      _data = data;
    });
  }

  void _incrementCounter() {
    fetchData(2023, 3);
    setState(() {});
  }

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
            child: const Text(drawerTitle)),
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
          title: const Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Day 1'),
          onTap: () {},
        ),
        ListTile(title: const Text('Day 2'), onTap: () {}),
      ])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FractionallySizedBox(
                heightFactor: .5,
                widthFactor: 1.0,
                child: Text(_data),
              ),
            ),
            Flexible(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(image: elfImage.image))),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
