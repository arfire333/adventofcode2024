import 'package:adventofcode2024/solutions/day02_solution.dart';
import 'package:flutter/material.dart';
import 'package:adventofcode2024/data.dart' as puzzle_data;

const int year = 2024;
const int day = 2;

class Day02Widget extends StatefulWidget {
  const Day02Widget({
    super.key,
  });

  @override
  State<Day02Widget> createState() => Day02WidgetState();
}

class Day02WidgetState extends State<Day02Widget> {
  Day02Solution data = Day02Solution();

  Future<void> runSolution() async {
    await data.fetchData(year, day);
    if (data.dataIsValid) {
      data.part1();
      data.part2();
    }
    setState(() => data = data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Day $day', textScaler: TextScaler.linear(1.5)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Part 1: '),
        SelectableText(data.answer1),
        IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () => runSolution(),
            tooltip: 'Run Solution'),
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => puzzle_data.erasePuzzleData(year, day),
            tooltip: 'Delete cached data'),
        const Text('Part 2: '),
        SelectableText(data.answer2),
      ]),
    ]);
  }
}
