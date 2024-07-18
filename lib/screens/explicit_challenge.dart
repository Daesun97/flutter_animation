import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExplicitChallengeScreen extends StatefulWidget {
  const ExplicitChallengeScreen({super.key});

  @override
  State<ExplicitChallengeScreen> createState() =>
      _ExplicitChallengeScreenState();
}

class _ExplicitChallengeScreenState extends State<ExplicitChallengeScreen>
    with TickerProviderStateMixin {
  late final List<AnimationController> _animationController;
  late final List<CurvedAnimation> _curves;
  late final List<Animation<Color?>> _colors;

  @override
  void initState() {
    super.initState();
    _animationController = List<AnimationController>.generate(
      25,
      (index) {
        return AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 800),
        );
      },
    );
    _curves = List<CurvedAnimation>.generate(
      25,
      (index) {
        return CurvedAnimation(
            parent: _animationController[index],
            curve: CustomJumpCurve(),
            reverseCurve: Curves.easeOutCirc);
      },
    );
    _colors = _curves.map((controller) {
      return ColorTween(
        begin: Colors.black,
        end: Colors.red,
      ).animate(controller);
    }).toList();

    _colorTransition();
  }

  List<int> _generateOrder(int rows, int cols) {
    //좌표 들어갈 리스트 만들고
    List<int> order = [];
    //가로
    for (int i = 0; i < rows; i++) {
      if (i % 2 == 0) {
        //세로
        for (int j = 0; j < cols; j++) {
          order.add(i * cols + j);
        }
        //가로가 홀수일때
      } else {
        for (int j = cols - 1; j >= 0; j--) {
          order.add(i * cols + j);
        }
      }
    }

    return order;
  }

  void _eachItemsStatusListener(AnimationStatus status, int index) async {
    if (!mounted) return;
    if (status == AnimationStatus.completed) {
      await Future.delayed(
        const Duration(milliseconds: 120),
      );
      if (!mounted) return;
      _animationController[index].reverse();
    } else if (status == AnimationStatus.dismissed) {
      await Future.delayed(
        const Duration(milliseconds: 800),
      );
      if (!mounted) return;

      _animationController[index].forward();
    }
  }

  void _colorTransition() async {
    final order = _generateOrder(5, 5);
    print('리스트 생긴거 $order');
    for (var index in order) {
      _animationController[index].forward();
      _animationController[index].addStatusListener(
          (AnimationStatus status) => _eachItemsStatusListener(status, index));
      //이거 없으면 한번에 다켜짐
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  void dispose() {
    for (var controller in _animationController) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Explicit Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Transform.flip(
            flipX: true,
            flipY: true,
            origin: const Offset(0, -100),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, crossAxisSpacing: 20, mainAxisSpacing: 20),
              children: List.generate(25, (index) {
                return AnimatedBuilder(
                  animation: _curves[index],
                  builder: (context, child) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          _animationController[index].value * 5),
                      color: _colors[index].value,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomJumpCurve extends Curve {
  @override
  double transformInternal(double t) {
    if (t < 0.33) {
      return 1.0; // First segment stays at 1
    } else if (t < 0.66) {
      return 0.0; // Second segment drops to 0
    } else {
      return 1.0; // Third segment goes back to 1
    }
  }
}
