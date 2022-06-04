import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({required this.text, required this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 58,
      minWidth: 100,
      focusElevation: 25,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      onPressed: onPressed,
      child: Stack(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Colors.white,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: Colors.black,
            ),
          ),
        ],
      ),
      color: const Color(0xFFCCFF90),
      //Color(0xFFF7CA18),
    );
  }
}

//Navigator.pushNamed(context, '/registration');
