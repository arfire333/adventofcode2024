import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:adventofcode2024/common.dart';
import 'package:adventofcode2024/solutions/day10_solution.dart';
import 'package:flutter/material.dart';

class Day10Widget extends StatefulWidget {
  const Day10Widget({
    super.key,
  });

  @override
  State<Day10Widget> createState() => _Day10WidgetState();
}

class _Day10WidgetState extends State<Day10Widget>
    with SingleTickerProviderStateMixin {
  Day10Solution data = Day10Solution();
  late AnimationController _controller;

  int frame = 0;
  double position = 0.0;
  bool forward = true;

  @override
  void initState() {
    super.initState();
    frame = 0;
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.addListener(() {
      position += (forward ? 1 : -1);
      if (position > 200 || position <= 0) {
        forward = !forward;
      }

      frame = position.toInt() % 4;
      data.step();
      setState(() {});
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> runSolution(context) async {
    if (await data.getPuzzleData(context)) {
      data.start();
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
      Stack(
        children: [
          Positioned.fill(
              left: position + 100,
              child: Transform.flip(flipX: forward, child: elfWalk[frame])),
          Center(
            child: Text('Day ${data.day}',
                textScaler: const TextScaler.linear(1.5)),
          ),
          Positioned.fill(
              left: -position - 100,
              child: Transform.flip(flipX: !forward, child: elfWalk[frame])),
        ],
      ),
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
          painter: _Day10Painter(data),
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

class _Day10Painter extends CustomPainter {
  Day10Solution data;
  _Day10Painter(this.data);
  final rand = Random();
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
    final List<Paint> paints = [];
    double scale = size.width / (data.map.length);
    int altitudes = 10;
    for (int i = 0; i < altitudes; i++) {
      int scaledAltitude = i * 255 ~/ altitudes;
      int transparency = 255;
      int blue = scaledAltitude;
      int red = blue;
      int green = blue;
      paints.add(Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale
        ..color = Color.fromARGB(transparency, red, green, blue));
    }
    final List<Paint> trailPaints = [];
    int increment = (1 / altitudes * 255).toInt();
    for (int i = 5; i <= altitudes; i++) {
      int scaledAltitude = i * increment;
      int transparency = 255;
      int value = scaledAltitude;
      trailPaints.add(Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale
        ..color = Color.fromARGB(transparency, value, 0, 0));
      trailPaints.add(Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale
        ..color = Color.fromARGB(transparency, 0, value, 0));
      trailPaints.add(Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale
        ..color = Color.fromARGB(transparency, 0, 0, value));
    }
    int trailCount = 3;
    int startTrail = data.currentTic;

    List<List<Offset>> trailPoints = [];
    for (int i = 0; i < trailPaints.length; i++) {
      trailPoints.add([]);
    }
    for (int i = startTrail; i < startTrail + trailCount * altitudes; i++) {
      int si = (i ~/ altitudes) % data.trails.length;
      int sp = (i - si * altitudes) % altitudes;
      int ci = si % trailPaints.length;
      int row = data.trails[si][sp].$1;
      int col = data.trails[si][sp].$2;
      trailPoints[ci].add(
          Offset(row.toDouble() * scale + scale / 2, col.toDouble() * scale));
    }
    for (int i = 0; i < trailPaints.length; i++) {
      canvas.drawPoints(PointMode.points, trailPoints[i], trailPaints[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
