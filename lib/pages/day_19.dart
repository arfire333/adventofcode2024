import 'package:adventofcode2024/solutions/day19_solution.dart';
import 'package:flutter/material.dart';

class Day19Widget extends StatefulWidget {
  const Day19Widget({
    super.key,
  });

  @override
  State<Day19Widget> createState() => _Day19WidgetState();
}

class _Day19WidgetState extends State<Day19Widget> {
  Day19Solution data = Day19Solution();

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
          painter: _Day19Painter(data),
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

class _Day19Painter extends CustomPainter {
  Day19Solution data;
  _Day19Painter(this.data);

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
