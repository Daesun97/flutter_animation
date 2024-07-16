import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  double _beginValue = 0.0;
  double _endValue = 1.0;
  bool _isCircle = false;

  @override
  void initState() {
    super.initState();
  }

  void _trigger() {
    setState(() {
      // 시작값 고정
      double temp = _beginValue;
      //시작값을 결과값으로 변환
      _beginValue = _endValue;
      //결과값을 다시 시작값으로 리셋
      _endValue = temp;

      _isCircle = !_isCircle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _isCircle ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: _isCircle ? Colors.white : Colors.black,
        title: Text(
          '암시적 애니메이션',
          style: TextStyle(
              color: _isCircle ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween(
            begin: _beginValue,
            end: _endValue,
          ),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          //noEnd : TweenAnimationBuilder를 만들고 제공된 Tween으로 이 인스턴스를 변경함
          onEnd: _trigger,
          builder: (context, value, child) {
            final left = value * (size.width * 0.6 - 10);
            final top = value * (size.width * 0.6 - 10);
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: _isCircle ? Colors.white : Colors.black,
                    shape: _isCircle ? BoxShape.circle : BoxShape.rectangle,
                  ),
                ),
                Positioned(
                  left: left,
                  child: Container(
                    width: 15,
                    height: size.width * 0.6,
                    color: _isCircle ? Colors.black : Colors.white,
                  ),
                ),
                Positioned(
                  left: top,
                  child: Container(
                    width: size.width * 0.5,
                    height: 15,
                    color: _isCircle ? Colors.black : Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
