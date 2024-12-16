import 'dart:ui';

import 'package:adventofcode2024/solutions/day15_solution.dart';
import 'package:flutter/material.dart';

class Day15Widget extends StatefulWidget {
  const Day15Widget({
    super.key,
  });

  @override
  State<Day15Widget> createState() => _Day15WidgetState();
}

class _Day15WidgetState extends State<Day15Widget>
    with SingleTickerProviderStateMixin {
  Day15Solution data = Day15Solution();
  late AnimationController _ac;

  Future<void> runSolution(context) async {
    if (await data.getPuzzleData(context)) {
      data.part1();
      data.part2();
      data.reset();
    }

    await data.getPuzzleText();
    setState(() {
      // Data is updated
    });
  }

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _ac.addListener(() {
      data.step();
      setState(() {});
    });
    _ac.repeat();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomPaint(
              painter: _Day15Painter(data),
              child: const FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: SingleChildScrollView(
                  child: SelectableText(''),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _Day15Painter extends CustomPainter {
  Day15Solution data;
  _Day15Painter(this.data);

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
    if (data.wideBoard.isEmpty) {
      return;
    }

    double hscale = size.width / (data.wideBoard[0].length);
    double vscale = size.height / (data.wideBoard.length);
    double scale = hscale;

    bool hshift = true;
    if (vscale < hscale) {
      scale = vscale;
    }

    final wallPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = scale
      ..color = Colors.green.shade900;

    final boxPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = scale
      ..color = const Color.fromARGB(255, 207, 190, 132);

    final elfPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = scale
      ..color = Colors.red;

    List<Offset> boxPoints = [];
    List<Offset> wallPoints = [];
    Offset elfPoint = toOffset(
      scale,
      data.wideRobot.r,
      data.wideRobot.c,
    );
    for (int r = 0; r < data.wideBoard.length; r++) {
      for (int c = 0; c < data.wideBoard[0].length; c++) {
        if (data.wideBoard[r][c] == '[' || data.wideBoard[r][c] == ']') {
          boxPoints.add(toOffset(scale, r, c));
        }
        if (data.wideBoard[r][c] == '#') {
          wallPoints.add(toOffset(scale, r, c));
        }
      }
    }
    if (hshift) {
      var shift = size.width - data.wideBoard[0].length * scale + scale / 2;
      canvas.translate(shift / 2 - 1, 0);
    }
    canvas.drawPoints(PointMode.points, boxPoints, boxPaint);
    canvas.drawPoints(PointMode.points, wallPoints, wallPaint);
    canvas.drawPoints(PointMode.points, [elfPoint], elfPaint);
  }

  Offset toOffset(double scale, int row, int col) {
    return Offset(col * scale + scale / 2, row * scale + scale / 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
