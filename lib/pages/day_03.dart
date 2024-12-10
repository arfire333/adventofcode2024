import 'package:adventofcode2024/solutions/day03_solution.dart';
import 'package:flutter/material.dart';

const int year = 2024;
const int day = 3;

class Day03Widget extends StatefulWidget {
  const Day03Widget({
    super.key,
  });

  @override
  State<Day03Widget> createState() => _Day03WidgetState();
}

class _Day03WidgetState extends State<Day03Widget> {
  Day03Solution data = Day03Solution();
  String puzzle = '';

  Future<void> runSolution(context) async {
    if (await data.getPuzzleData(context)) {
      data.part1();
      data.part2();
    }

    await data.getPuzzleText();
    setState(() {
      // Data is updated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Day ${data.day}', textScaler: const TextScaler.linear(1.5)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Part 1: '),
        SelectableText(data.answer1),
        IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              runSolution(context);
            },
            tooltip: 'Run solution'),
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              data.erasePuzzleData();
              data.erasePuzzleText();
              setState(() {
                // Cleared puzzle from data
              });
            },
            tooltip: 'Delete cached data'),
        IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await data.erasePuzzleText();
              await data.getPuzzleText();
              setState(() {
                // Pulled new Puzzle text
              });
            },
            tooltip: 'Refresh puzzle text'),
        const Text('Part 2: '),
        SelectableText(data.answer2),
      ]),
      Flexible(
        child: CustomPaint(
          painter: _Day03Painter(data),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: SingleChildScrollView(
              child: SelectableText(
                data.puzzleText,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _Day03Painter extends CustomPainter {
  Day03Solution data;
  _Day03Painter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final redLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color.fromARGB(50, 255, 0, 0);

    final greenLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color.fromARGB(50, 0, 255, 0);

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
