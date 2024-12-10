import 'dart:math';
import 'package:adventofcode2024/solutions/day01_solution.dart';
import 'package:flutter/material.dart';

class Day01Widget extends StatefulWidget {
  const Day01Widget({
    super.key,
  });

  @override
  State<Day01Widget> createState() => _Day01WidgetState();
}

class _Day01WidgetState extends State<Day01Widget> {
  Day01Solution data = Day01Solution();

  Future<void> runSolution(BuildContext context) async {
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
            tooltip: 'Run Solution'),
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
              painter: _Day01Painter(data),
              child: const FractionallySizedBox(
                  widthFactor: 1.0, heightFactor: 1.0)))
    ]);
  }
}

class _Day01Painter extends CustomPainter {
  Day01Solution data;
  _Day01Painter(this.data);

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

    var max = 0;
    for (int i = 0; i < data.left.length; i++) {
      if (data.left[i] > max) {
        max = data.left[i];
      }
    }

    var padding = 20.0;
    var height = (size.height - 4 * padding) / 4;

    for (int i = 0; i < min(size.width - 2 * padding, data.left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, height + padding * 2);
      Offset p2 = Offset(i.toDouble() + padding,
          data.left[i].toDouble() * height / max + padding * 2);
      canvas.drawLine(p1, p2, redLine);
    }

    for (int i = 0; i < min(size.width - 2 * padding, data.left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, height + padding * 2);
      Offset p2 = Offset(i.toDouble() + padding,
          data.right[i].toDouble() * height / max + padding * 2);
      canvas.drawLine(p1, p2, greenLine);
    }

    for (int i = 0; i < min(size.width - 2 * padding, data.left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, 1 * height + 4 * padding);
      Offset p2 = Offset(
          i.toDouble() + padding,
          data.sortedLeft[i].toDouble() * height / max +
              1 * height +
              4 * padding);
      canvas.drawLine(p1, p2, redLine);
    }

    for (int i = 0; i < min(size.width - 2 * padding, data.left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, 1 * height + 4 * padding);
      Offset p2 = Offset(
          i.toDouble() + padding,
          data.sortedRight[i].toDouble() * height / max +
              1 * height +
              4 * padding);
      canvas.drawLine(p1, p2, greenLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
