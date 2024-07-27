import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class finalChallange extends StatefulWidget {
  const finalChallange({super.key});

  @override
  State<finalChallange> createState() => _finalChallangeState();
}

class _finalChallangeState extends State<finalChallange>
    with TickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  int _index = 0;
  double get _progressEnd => max(
        0.05,
        _index / 3,
      );
  late final AnimationController _horizontalDragController =
      AnimationController(
    lowerBound: size.width * -1 - 200,
    upperBound: size.width + 200,
    duration: const Duration(
      seconds: 1,
    ),
    value: 0.0,
    vsync: this,
  );

  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final CurvedAnimation _curvedProgressAnimation = CurvedAnimation(
    parent: _progressController,
    curve: Curves.ease,
  );

  late Animation<double> _progress = Tween<double>(
    begin: 0.05,
    end: 3,
  ).animate(
    _curvedProgressAnimation,
  );

  void _animateProgress({
    required double begin,
    required double end,
  }) {
    _progressController.reset();
    _progress = Tween<double>(
      begin: begin,
      end: end,
    ).animate(_curvedProgressAnimation);

    _progressController.forward();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_horizontalDragController.value < -120) {
      _horizontalDragController.reverse().whenComplete(
            _whenComplete,
          );
    } else if (_horizontalDragController.value > 120) {
      _horizontalDragController.forward().whenComplete(
            _whenComplete,
          );
    } else {
      _horizontalDragController.animateTo(
        0.0,
        curve: Curves.ease,
      );
    }
  }

  void _whenComplete() {
    final prevProgressEnd = _progressEnd;
    setState(() {
      _horizontalDragController.value = 0.0;
      _index += 1;
      _animateProgress(
        begin: prevProgressEnd,
        end: _progressEnd,
      );
    });
  }

  @override
  void dispose() {
    _horizontalDragController.dispose();
    _progressController.dispose();
    _curvedProgressAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _horizontalDragController,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.center,
              children: [
                EndText(index: _index),
                Image.asset('assets/country/${_index + 1}.jpg')
              ],
            ),
          ),
        );
      },
    );
  }
}

class EndText extends StatelessWidget {
  const EndText({
    super.key,
    required int index,
  }) : _index = index;

  final int _index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _index == 3 ? 1 : 0,
        child: const Text(
          "끝!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
