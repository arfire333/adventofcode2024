import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adventofcode2024/data.dart' as puzzle_data;

class Day01Widget extends StatefulWidget {
  const Day01Widget({
    super.key,
  });

  @override
  State<Day01Widget> createState() => _Day01WidgetState();
}

class _Day01WidgetState extends State<Day01Widget> {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  List<int> left = List<int>.empty(growable: true);
  List<int> right = List<int>.empty(growable: true);
  List<int> sortedLeft = List<int>.empty(growable: true);
  List<int> sortedRight = List<int>.empty(growable: true);
  bool ready = false;
  String answer1 = '';
  String answer2 = '';

  Future<void> fetchData(int year, int day) async {
    var data = await puzzle_data.fetchPuzzleData(2024, 1);
    left.clear();
    right.clear();

    var lines = data.split('\n');

    for (var line in lines) {
      if (line.isEmpty) {
        continue;
      }
      final re = RegExp(r'( +)');
      var entries = line.split(re);

      left.add(int.parse(entries[0]));
      right.add(int.parse(entries[1]));
    }

    setState(() {
      answer1 = part1();
      answer2 = part2();
    });
    dev.log(answer1);
    dev.log(answer2);
  }

  String part1() {
    sortedLeft = List<int>.from(left);
    sortedLeft.sort();
    sortedRight = List<int>.from(right);
    sortedRight.sort();
    var sum = 0;
    // Part 1
    for (int i = 0; i < sortedLeft.length; i++) {
      sum += (sortedLeft[i] > sortedRight[i]
          ? sortedLeft[i] - sortedRight[i]
          : sortedRight[i] - sortedLeft[i]);
    }

    return 'Part 1 answer: $sum';
  }

  String part2() {
    Map<int, int> counts = <int, int>{};
    for (var value in left) {
      counts[value] = 0;
    }

    for (var value in right) {
      int last = counts[value] ?? -1;
      if (last >= 0) {
        counts[value] = last + 1;
      }
    }

    var total = 0;
    counts.forEach((key, value) {
      total += key * value;
    });

    return 'Part 2 answer: $total';
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(
        icon: const Icon(Icons.play_arrow),
        onPressed: () {
          fetchData(2024, 1);
        },
      ),
      Flexible(
          child: CustomPaint(
              painter: _Day01Painter(
                  left, right, sortedLeft, sortedRight, answer1, answer2),
              child: const FractionallySizedBox(
                  widthFactor: 1.0, heightFactor: 1.0)))
    ]);
  }
}

class _Day01Painter extends CustomPainter {
  List<int> left;
  List<int> right;
  List<int> sortedLeft;
  List<int> sortedRight;
  String answer1;
  String answer2;
  _Day01Painter(this.left, this.right, this.sortedLeft, this.sortedRight,
      this.answer1, this.answer2);

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
    for (int i = 0; i < left.length; i++) {
      if (left[i] > max) {
        max = left[i];
      }
    }

    var padding = 20.0;
    var height = (size.height - 4 * padding) / 4;

    for (int i = 0; i < min(size.width - 2 * padding, left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, height + padding * 2);
      Offset p2 = Offset(i.toDouble() + padding,
          left[i].toDouble() * height / max + padding * 2);
      canvas.drawLine(p1, p2, redLine);
    }

    for (int i = 0; i < min(size.width - 2 * padding, left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, height + padding * 2);
      Offset p2 = Offset(i.toDouble() + padding,
          right[i].toDouble() * height / max + padding * 2);
      canvas.drawLine(p1, p2, greenLine);
    }

    for (int i = 0; i < min(size.width - 2 * padding, left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, 1 * height + 4 * padding);
      Offset p2 = Offset(i.toDouble() + padding,
          sortedLeft[i].toDouble() * height / max + 1 * height + 4 * padding);
      canvas.drawLine(p1, p2, redLine);
    }

    for (int i = 0; i < min(size.width - 2 * padding, left.length); i++) {
      Offset p1 = Offset(i.toDouble() + padding, 1 * height + 4 * padding);
      Offset p2 = Offset(i.toDouble() + padding,
          sortedRight[i].toDouble() * height / max + 1 * height + 4 * padding);
      canvas.drawLine(p1, p2, greenLine);
    }
    // Draw answer
    final textStyle = TextStyle(color: Colors.green, fontSize: padding);
    final answer1Painter = TextPainter(
        text: TextSpan(text: answer1, style: textStyle),
        textDirection: TextDirection.ltr);
    answer1Painter.layout();
    var textOffset = Offset(padding, 0);
    answer1Painter.paint(canvas, textOffset);
    final answer2Painter = TextPainter(
        text: TextSpan(text: answer2, style: textStyle),
        textDirection: TextDirection.ltr);
    answer2Painter.layout();
    answer2Painter.paint(canvas, textOffset + Offset(0, padding));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
