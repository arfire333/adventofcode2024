import 'package:adventofcode2024/solutions/day05_solution.dart';
import 'package:flutter/material.dart';
import 'package:adventofcode2024/data.dart' as puzzle_data;

const int year = 2024;
const int day = 05;

class Day05Widget extends StatefulWidget {
  const Day05Widget({
    super.key,
  });

  @override
  State<Day05Widget> createState() => _Day05WidgetState();
}

class _Day05WidgetState extends State<Day05Widget> {
  Day05Solution data = Day05Solution();

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
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => puzzle_data.erasePuzzle(year, day),
            tooltip: 'Delete puzzle text'),
        const Text('Part 2: '),
        SelectableText(data.answer2),
      ]),
      Expanded(
          child: SingleChildScrollView(child: SelectableText(data.puzzleText))),
      Flexible(
          child: CustomPaint(
              painter: _Day05Painter(data),
              child: const FractionallySizedBox(
                  widthFactor: 1.0, heightFactor: 1.0)))
    ]);
  }
}

class _Day05Painter extends CustomPainter {
  Day05Solution data;
  _Day05Painter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final redLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.red;

    final greenLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.green;

    for (double i = 0; i <= size.width; i += 10) {
      Offset p1 = Offset(i, 0);
      Offset p2 = Offset(i, size.height);
      canvas.drawLine(p1, p2, greenLine);
    }
    for (double i = 0; i <= size.height; i += 10) {
      Offset p1 = Offset(0, i);
      Offset p2 = Offset(size.width, i);
      canvas.drawLine(p1, p2, redLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
