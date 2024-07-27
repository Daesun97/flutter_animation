import 'package:flutter/material.dart';
import 'package:flutter_animations_study/card_challenge/card_challenge_screen.dart';
import 'package:flutter_animations_study/final_challenge/animation_challange.dart';
import 'package:flutter_animations_study/screens/custompainter.dart';
import 'package:flutter_animations_study/screens/explicit_animation.dart';
import 'package:flutter_animations_study/screens/explicit_challenge.dart';
import 'package:flutter_animations_study/screens/implicit_animation.dart';
import 'package:flutter_animations_study/musicPlayer/musicplayer_screen.dart';
import 'package:flutter_animations_study/screens/pomodoro_challenge.dart';
import 'package:flutter_animations_study/screens/shared_axis_screen.dart';
import 'package:flutter_animations_study/screens/swiping_cards_screen.dart';
import 'package:flutter_animations_study/screens/wallet_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Animation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const ImplicitAnimationScreen(),
                );
              },
              child: const Text('implicit Animations'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const ExplicitAnimationScreen(),
                );
              },
              child: const Text('Explicit Animation'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const ExplicitChallengeScreen(),
                );
              },
              child: const Text(
                'Explicit Challange',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const AppleWatchScreen(),
                );
              },
              child: const Text(
                'Apple Watch',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const PomodoroScreen(),
                );
              },
              child: const Text(
                'Pomodoro Challenge',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const SwipingCardsScreen(),
                );
              },
              child: const Text(
                'Swiping Gesture',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const CardChallenge(),
                );
              },
              child: const Text(
                'Swiping Challenge',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const MusicPlayerScreen(),
                );
              },
              child: const Text(
                'Mushic Player',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const SharedAxisScreen(),
                );
              },
              child: const Text(
                'Axis Animation',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const WalletScreen(),
                );
              },
              child: const Text(
                'Card Wallet',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const finalChallange(),
                );
              },
              child: const Text(
                'Fianl Challenge',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
