import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(16),
  labelText: 'Type your message ...',
  labelStyle: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),
  floatingLabelStyle:
      TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
  filled: true,
  fillColor: Color(0xFFEEEEEE),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    gapPadding: 10,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    gapPadding: 10,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    gapPadding: 10,
  ),
);

const kMessageContainerDecoration = BoxDecoration(
  color: Color(0xFFEFEBE9),
  border: Border(
    top: BorderSide(color: Colors.black26, width: 2.0),
  ),
);

const kAppInfo = Text(
  'Share Your Thoughts Anonymously',
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.redAccent,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
  ),
);

const kTextField = InputDecoration(
  hintText: 'Enter A Value',
  hintStyle: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(13.0)),
  ),
);

const kFuelledBy = Text(
  'fuelled by:\n CodoWeb',
  textAlign: TextAlign.center,
  style: TextStyle(
    fontFamily: 'Pacifico',
    color: Colors.orange,
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
  ),
);

void showToastError(String errorMessage, BuildContext context) {
  showToast(
    errorMessage,
    context: context,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.center,
    animDuration: const Duration(seconds: 2),
    duration: const Duration(seconds: 5),
    curve: Curves.elasticOut,
    reverseCurve: Curves.easeInOut,
    backgroundColor: Colors.lightGreenAccent,
    textStyle: const TextStyle(
      color: Colors.black,
      fontStyle: FontStyle.italic,
      fontSize: 18,
    ),
    borderRadius: BorderRadius.circular(13),
  );
}

void showToastWidget(String message, BuildContext context) {
  showToast(
    message,
    context: context,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.center,
    animDuration: const Duration(seconds: 2),
    duration: const Duration(seconds: 10),
    curve: Curves.elasticOut,
    reverseCurve: Curves.easeInOut,
    backgroundColor: const Color(0xFFFF5252),
    textStyle: const TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.italic,
      fontSize: 18,
    ),
    borderRadius: BorderRadius.circular(13),
  );
}
