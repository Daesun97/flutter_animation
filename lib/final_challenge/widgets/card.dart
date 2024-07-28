import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

List<String> _beens = ['', '아라비카', '로부스타', '리베리카'];
double cardSize(Size size) => size.width * 0.8;

class CoffeeCard extends StatefulWidget {
  final bool isCardtap;
  final int index;
  final Function onTap;
  const CoffeeCard(
      {super.key,
      required this.isCardtap,
      required this.index,
      required this.onTap});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  bool _istap = false;

  void _onTap() async {
    setState(() {
      _istap = true;
    });
    widget.onTap();

    await Future.delayed(500.milliseconds);

    setState(() {
      _istap = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: cardSize(size) * 0.8,
        width: cardSize(size) * 0.8,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurStyle: BlurStyle.normal,
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/coffee/beens/${widget.index + 1}.jpg"),
          ),
        ),
        child: _istap
            ? null
            : Center(
                child: Text(
                  _beens[widget.index],
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
      ),
    ).animate(target: _istap ? 0 : 1).scale(
          begin: const Offset(1.3, 1.3),
          end: const Offset(0.9, 0.9),
          duration: 900.milliseconds,
          curve: curves[widget.index],
        );
  }
}

List<Curve> curves = [
  Curves.bounceOut,
  Curves.easeOutBack,
  Curves.elasticInOut,
  Curves.linear
];
