import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:adventofcode2024/strings.dart' as strings;

enum StraightMeterOrientation { vertical, horizontal }

var angleFormat = intl.NumberFormat('0.0°');

class TemplateWidget extends StatelessWidget {
  const TemplateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _TemplatePainter(),
        child: const FractionallySizedBox(widthFactor: 1.0, heightFactor: 1.0));
  }
}

class _TemplatePainter extends CustomPainter {
  _TemplatePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final redLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.red;

    final redFill = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.red;

    final greenLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.green;

    final greenFill = Paint()
      ..style = PaintingStyle.fill
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
