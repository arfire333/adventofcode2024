import 'dart:ui';

import 'package:adventofcode2024/solutions/day14_solution.dart';
import 'package:flutter/material.dart';

class Day14Widget extends StatefulWidget {
  const Day14Widget({
    super.key,
  });

  @override
  State<Day14Widget> createState() => _Day14WidgetState();
}

class _Day14WidgetState extends State<Day14Widget>
    with SingleTickerProviderStateMixin {
  Day14Solution data = Day14Solution();

  late AnimationController _ac;
  int step = 0;
  int stepIncrement = 1;
  int counter = 0;
  double score = 0;
  Future<void> runSolution(context) async {
    if (await data.getPuzzleData(context)) {
      data.part1();
      data.resetData();
      step = 0;
      counter = 0;

      _ac.repeat(period: Duration(milliseconds: 100));
    }

    await data.getPuzzleText();
    setState(() {
      // Data is updated
    });
  }

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this);

    _ac.addListener(() {
      step++;
      if (step % stepIncrement == 0) {
        counter++;

        data.step();
        var (q1, q2, q3, q4) = data.stats();
        score = q3 * q4;
        if (q3 < 350 && q4 < 350) {
          _ac.stop();
        }
        data.answer2 = '$counter';
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Day ${data.day}  Step ${step}  Counter ${counter}',
          textScaler: const TextScaler.linear(1.5)),
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
          painter: _Day14Painter(data),
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

class _Day14Painter extends CustomPainter {
  Day14Solution data;
  _Day14Painter(this.data);

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

    List<Offset> robots = [];
    double scale = size.width / data.w;
    for (var r in data.robots) {
      robots.add(Offset(r.x.toDouble() * scale + scale / 2,
          r.y.toDouble() * scale + scale / 2));
    }

    final greenThickLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = scale
      ..color = const Color.fromARGB(255, 0, 255, 0);

    canvas.drawPoints(PointMode.points, robots, greenThickLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
