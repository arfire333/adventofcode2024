import 'dart:math';

import 'package:adventofcode2024/common.dart';
import 'package:adventofcode2024/solutions/day13_solution.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class Day13Widget extends StatefulWidget {
  const Day13Widget({
    super.key,
  });

  @override
  State<Day13Widget> createState() => _Day13WidgetState();
}

Random r = Random();

class _Day13WidgetState extends State<Day13Widget>
    with SingleTickerProviderStateMixin {
  Day13Solution data = Day13Solution();
  late AnimationController _ac;
  // For the game.
  (double, double) clawPosition = (0, 0);
  (double, double) prizeLocation = (-1, -1);
  int score = 0;
  double tic = 0;
  double lastTic = 0;

  GlobalKey rowKey = GlobalKey(debugLabel: 'rowKey');
  GlobalKey boardKey = GlobalKey(debugLabel: 'boardKey');
  var boardSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this);
    _ac.addListener(() {
      tic++;
      if (aPressed) {
        // aPress(tic - lastTic);
        aPress(tic - lastTic);
      } else if (bPressed) {
        bPress(tic - lastTic);
      }
      lastTic = tic;
      setState(() {});
    });
    _ac.repeat(period: Duration(seconds: 1));
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        boardSize = getBoardSize(boardKey.currentContext!);
        resetGame();
      });
    });
  }

  void aPress(double change) {
    var x = clawPosition.$1 + change;
    x = max(0, x);
    x = min(boardSize.width - 35, x);
    clawPosition = (x, clawPosition.$2);
  }

  void bPress(double change) {
    var y = clawPosition.$2 + change;
    y = max(0, y);
    y = min(boardSize.height - 70, y);
    clawPosition = (clawPosition.$1, y);
  }

  Size getBoardSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  }

  void resetGame() {
    setState(() {
      clawPosition = (0, 0);
      prizeLocation = (
        r.nextDouble() * (boardSize.width - 55),
        r.nextDouble() * (boardSize.height - 80),
      );
      score = 100;
    });
  }

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

  bool aPressed = false;
  bool bPressed = false;
  DateTime aStartPress = DateTime.now();
  DateTime bStartPress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Day ${data.day}', textScaler: const TextScaler.linear(1.5)),
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
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton.icon(
          label: const Text('New Game'),
          onPressed: () => resetGame(),
          iconAlignment: IconAlignment.end,
          // icon: const Icon(Icons.play_arrow),
        ),
        Text('   $score   '),
        ElevatedButton.icon(
          label: Text('Reset Score'),
          onPressed: () {
            setState(() {
              score = 0;
            });
          },
          iconAlignment: IconAlignment.end,
          // icon: const Icon(Icons.delete),
        ),
      ]),
      Flexible(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          padding: const EdgeInsets.all(5.0),
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: CustomPaint(
              painter: _Day13Painter(data),
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Stack(
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        NotificationListener(
                          onNotification: (a) {
                            boardSize = getBoardSize(boardKey.currentContext!);
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              setState(() {});
                            });

                            return true;
                          },
                          child: Expanded(
                            key: boardKey,
                            child:
                                SizeChangedLayoutNotifier(child: Container()),
                          ),
                        ),
                        Center(
                          child: Row(
                            key: rowKey,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    score -= 3;
                                    aPressed = true;
                                  });
                                },
                                child: CircleButton(
                                  'A',
                                  onPressed: () {
                                    Future.delayed(
                                        Duration(milliseconds: r.nextInt(1000)),
                                        () {
                                      setState(() {
                                        aPressed = false;
                                      });
                                    });
                                  },
                                  color: Colors.redAccent.shade700,
                                  backgroundColor: Colors.green.shade900,
                                ),
                              ),
                              CircleButton(
                                'C',
                                onPressed: () {
                                  if (aPressed || bPressed) {
                                    return;
                                  }
                                  calcScore();
                                  setState(() {});
                                },
                              ),
                              GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    score -= 1;
                                    bPressed = true;
                                  });
                                },
                                child: CircleButton(
                                  'B',
                                  onPressed: () {
                                    Future.delayed(
                                        Duration(milliseconds: r.nextInt(1000)),
                                        () {
                                      setState(() {
                                        bPressed = false;
                                      });
                                    });
                                  },
                                  color: Colors.green.shade900,
                                  backgroundColor: Colors.redAccent.shade700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: prizeLocation.$1.toDouble(),
                      top: prizeLocation.$2.toDouble(),
                      child: const Text(
                        textScaler: TextScaler.linear(4),
                        '🎁',
                      ),
                    ),
                    Positioned(
                      left: clawPosition.$1.toDouble(),
                      top: clawPosition.$2.toDouble(),
                      child: SizedBox(
                          height: 70,
                          child:
                              Image(image: elfImage.image, fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void calcScore() {}
}

class _Day13Painter extends CustomPainter {
  Day13Solution data;
  _Day13Painter(this.data);

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

class CircleButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color backgroundColor;

  const CircleButton(this.label,
      {required this.onPressed,
      this.color = Colors.white,
      this.backgroundColor = Colors.black,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: const WidgetStatePropertyAll(CircleBorder()),
        fixedSize: const WidgetStatePropertyAll(Size.fromRadius(50)),
      ),
      onPressed: () => onPressed(),
      child: Text(
        label,
        textScaler: const TextScaler.linear(5),
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.aBeeZee.toString()),
        textAlign: TextAlign.center,
      ),
    );
  }
}
