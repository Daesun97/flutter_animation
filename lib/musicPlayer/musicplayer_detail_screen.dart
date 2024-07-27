import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$minutes:$seconds";
}

class MusicPlayerDetail extends StatefulWidget {
  final int index;
  final duration = const Duration(
    seconds: 60,
  );

  const MusicPlayerDetail({super.key, required this.index});

  @override
  State<MusicPlayerDetail> createState() => _MushicPlayerDetailState();
}

class _MushicPlayerDetailState extends State<MusicPlayerDetail>
    with TickerProviderStateMixin {
  late final AnimationController _progressController =
      AnimationController(vsync: this, duration: const Duration(seconds: 25))
        ..repeat(reverse: true);

  late final AnimationController _marqueeController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat(reverse: true);

  late final AnimationController _playPuaseController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 1,
    ),
  );

  late final size = MediaQuery.of(context).size;

  bool _dragging = false;

  void _toggleDragging() {
    setState(() {
      _dragging = !_dragging;
    });
  }

  late final Animation<Offset> _marqueeTween = Tween(
    begin: const Offset(0.1, 0),
    end: const Offset(-0.6, 0),
  ).animate(_marqueeController);

  void _onPlayPauseTap() {
    if (_playPuaseController.isCompleted) {
      _playPuaseController.reverse();
    } else {
      _playPuaseController.forward();
    }
  }

  final ValueNotifier<double> _volume = ValueNotifier(0);

  void _dragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;

    _volume.value = _volume.value.clamp(0.0, size.width * 0.8);
  }

  void _openMenu() {}

  @override
  void dispose() {
    _progressController.dispose();
    _marqueeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아오더워'),
        actions: [
          IconButton(
            onPressed: _openMenu,
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: "${widget.index}",
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/country/${widget.index}.jpg",
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) => CustomPaint(
              painter: ProgressBar(progressValue: _progressController.value),
              size: Size(size.width * 0.8, 10),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                final currentDuration =
                    widget.duration * _progressController.value;
                final rightDuration = widget.duration -
                    currentDuration +
                    const Duration(seconds: 1);
                return Row(
                  children: [
                    Text(
                      formatDuration(currentDuration),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      formatDuration(rightDuration),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "너무 더운 여름",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SlideTransition(
            position: _marqueeTween,
            child: const Text(
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              '지금까지 이런 더위는 없었다 이건 한국인가 정글인가, 안녕하세요 더운 여름입니다',
            ),
          ),
          GestureDetector(
            onTap: _onPlayPauseTap,
            child: LottieBuilder.asset(
              width: 100,
              height: 100,
              "assets/animation/play_lottie.json",
              controller: _playPuaseController,
              onLoaded: (composition) {
                _playPuaseController.duration = composition.duration;
              },
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          GestureDetector(
            onHorizontalDragUpdate: _dragUpdate,
            onHorizontalDragStart: (_) => _toggleDragging(),
            onHorizontalDragEnd: (_) => _toggleDragging(),
            child: AnimatedScale(
              scale: _dragging ? 1.1 : 1,
              duration: const Duration(microseconds: 500),
              curve: Curves.bounceOut,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ValueListenableBuilder(
                  valueListenable: _volume,
                  builder: (context, volume, child) => CustomPaint(
                    size: Size(size.width * 0.8, 20),
                    painter: VolumPaint(volume: volume),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({required this.progressValue});

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;
    // 백그라운드 트랙
    final trackPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(
      trackRRect,
      trackPaint,
    );

    //진행도
    final progressPaint = Paint()
      ..color = Colors.amber.shade700
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      const Radius.circular(10),
    );
    canvas.drawRRect(progressRRect, progressPaint);

    //손잡이
    canvas.drawCircle(Offset(progress, size.height / 2), 15, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}

class VolumPaint extends CustomPainter {
  final double volume;
  VolumPaint({required this.volume});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.grey.shade400;

    final bgRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    canvas.drawRect(bgRect, bgPaint);

    final volumePaint = Paint()..color = Colors.grey.shade500;

    final volumeRect = Rect.fromLTWH(
      0,
      0,
      volume,
      size.height,
    );

    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumPaint oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
