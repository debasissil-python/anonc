import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({required this.text, required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          text,
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: fontSize,
            //45.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
            fontStyle: FontStyle.italic,
          ),
          colors: [
            Colors.blueGrey.shade900,
            Colors.yellow,
            Colors.red,
            Colors.purple,
          ],
        ),
      ],
    );
  }
}
