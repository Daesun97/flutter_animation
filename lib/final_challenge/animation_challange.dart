import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animations_study/final_challenge/widgets/bg_blur.dart';
import 'package:flutter_animations_study/final_challenge/widgets/card.dart';
import 'package:flutter_animations_study/final_challenge/widgets/explanation.dart';

class finalChallange extends StatefulWidget {
  const finalChallange({super.key});

  @override
  State<finalChallange> createState() => _finalChallangeState();
}

class _finalChallangeState extends State<finalChallange>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  late final size = MediaQuery.of(context).size;

  late final PageController _fgPageController = PageController(
    viewportFraction: 1.5,
  );

  late final PageController _bgPageController = PageController(
    viewportFraction: 0.8,
  );

  late final AnimationController _verticalController = AnimationController(
    vsync: this,
  );

  bool _isPlayPauseTap = false;

  void _onPlayPauseTap() {
    setState(() {
      _isPlayPauseTap = !_isPlayPauseTap;
    });
  }

  @override
  void initState() {
    super.initState();
    _fgPageController.addListener(_sync);
  }

  void _sync() {
    _bgPageController.position.jumpTo(
      (_fgPageController.position.pixels / 1.5 - size.width / 6) * 0.8,
    );
  }

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundBlur(
              currentPage: _currentPage,
              verticalController: _verticalController,
              isAlbumTap: _isPlayPauseTap),
          ExplainationCard(
              bgPageController: _bgPageController,
              size: size,
              isAlbumTap: _isPlayPauseTap),
          Positioned.fill(
            child: PageView.builder(
              controller: _fgPageController,
              onPageChanged: _onPageChanged,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 180,
                      child: CoffeeCard(
                          isCardtap: _isPlayPauseTap,
                          index: index,
                          onTap: _onPlayPauseTap),
                    ),
                  ],
                );
              },
            ),
          )
              .animate(
                target: _isPlayPauseTap ? 1 : 0,
              )
              .slideY(
                begin: 0,
                end: -0.1,
                duration: 0.8.seconds,
                curve:
                    _isPlayPauseTap ? Curves.easeInOutQuart : Curves.easeInExpo,
              ),
        ],
      ),
    );
  }
}
