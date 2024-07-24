import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();
  late Timer timer;
  bool _isRunning = false;

  static const fifteenMinuts = 10;
  final int initTotalSeconds = fifteenMinuts * 60;
  int totalSeconds = fifteenMinuts * 60;

  int formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    print(duration);
    return int.parse(duration.toString().split(".").first.substring(2, 4));
  }

  String formatMilliSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  void onTick(Timer timer) {
    _animateValues();
    if (totalSeconds == 0) {
      timer.cancel();

      setState(() {
        _isRunning = false;
      });
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    if (_isRunning) return;

    timer = Timer.periodic(
      //seconds는 왜안돼지 꿀꿀
      //const Duration(seconds: 1),
      const Duration(milliseconds: 1),
      onTick,
    );
    setState(() {
      _isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void onStopPressed() {
    if (_isRunning) {
      timer.cancel();
    }
    setState(() {
      _isRunning = false;
      totalSeconds = initTotalSeconds;
    });
    _animateValues();
  }

  void onReplayPressed() {
    onStopPressed();

    onStartPressed();
  }

  late Animation<double> _progress = Tween(
    begin: 0.005,
    end: 0.005,
  ).animate(_animationController);

  void _animateValues() {
    setState(() {
      _progress = Tween(
        begin: _progress.value,
        end: max(
            0.005, (initTotalSeconds - totalSeconds) * 2.0 / initTotalSeconds),
      ).animate(_animationController);
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('제출용 10초타이머'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${formatSeconds(totalSeconds)}',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            color: formatSeconds(totalSeconds) <= 5
                                ? Colors.red.shade400
                                : Colors.black),
                      ),
                      Text(
                        " : ",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            color: formatSeconds(totalSeconds) <= 5
                                ? Colors.red.shade400
                                : Colors.black),
                      ),
                      Text(
                        formatMilliSeconds(totalSeconds),
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            color: formatSeconds(totalSeconds) <= 5
                                ? Colors.red.shade400
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _progress,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: CircleTimerPainter(
                        progress: _progress.value,
                      ),
                      size: const Size(300, 300),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onReplayPressed,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  width: 70,
                  height: 70,
                  child: Icon(
                    Icons.replay_outlined,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: _isRunning ? onPausePressed : onStartPressed,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade400,
                  ),
                  width: 100,
                  height: 100,
                  child: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: onStopPressed,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  width: 70,
                  height: 70,
                  child: Icon(
                    Icons.stop,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CircleTimerPainter extends CustomPainter {
  final double progress;

  CircleTimerPainter({
    super.repaint,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    const startingAngle = -0.5 * pi;

    // 원그리기
    final circlePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final circleRadius = (size.width / 2) * 0.9;

    canvas.drawCircle(
      center,
      circleRadius,
      circlePaint,
    );

    //붉은 호
    final redArcRect = Rect.fromCircle(
      center: center,
      radius: circleRadius,
    );

    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      redArcRect,
      startingAngle,
      progress * pi,
      false,
      redArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircleTimerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
