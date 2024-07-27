import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SharedAxisScreen extends StatefulWidget {
  const SharedAxisScreen({super.key});

  @override
  State<SharedAxisScreen> createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _currentImage = 1;
  void _goToImage(int newImage) {
    setState(() {
      _currentImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Axis'),
      ),
      body: Column(
        children: [
          PageTransitionSwitcher(
            duration: 2.seconds,
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            ),
            child: Container(
              key: ValueKey(_currentImage),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.asset("assets/country/$_currentImage.jpg"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'data',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var btn in [1, 2, 3, 4])
                ElevatedButton(
                  onPressed: () => _goToImage(btn),
                  child: Text('$btn'),
                )
            ],
          )
        ],
      ),
    );
  }
}
