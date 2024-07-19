import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 3,
    ),
  )..forward();

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceInOut,
  );

  late Animation<double> _progress = Tween(
    begin: 0.005,
    end: 2.0,
  ).animate(_curve);

  void _animatedvalues() {
    final newBegin = _progress.value;
    final random = Random();
    final newend = random.nextDouble() * 2.0;
    setState(() {
      _progress = Tween(
        begin: newBegin,
        end: newend,
      ).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _curve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Apple Watch'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(progress: _progress.value),
              size: const Size(400, 400),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animatedvalues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.width / 2);

    const startingAngle = -0.5 * pi;
    //빨간원
    final redCirclePAint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.8, redCirclePAint);

    //초록원
    final greenCirclePAint = Paint()
      ..color = Colors.green.shade400.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.65, greenCirclePAint);

    //파란 원

    final blueCirclePAint = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.5, blueCirclePAint);

    // 빨간 호

    final redArcRect =
        Rect.fromCircle(center: center, radius: (size.width / 2) * 0.8);

    final redArcPaint = Paint()
      ..color = Colors.red.shade600
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

    //초록색 호
    final greenArcRect =
        Rect.fromCircle(center: center, radius: (size.width / 2) * 0.65);

    final greenArcPaint = Paint()
      ..color = Colors.green.shade600
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      greenArcRect,
      startingAngle,
      progress * pi,
      false,
      greenArcPaint,
    );
    //파란색 호
    final blueArcRect =
        Rect.fromCircle(center: center, radius: (size.width / 2) * 0.5);

    final blueArcPaint = Paint()
      ..color = Colors.blue.shade600
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      blueArcRect,
      startingAngle,
      progress * pi,
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
