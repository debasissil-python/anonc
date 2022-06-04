// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../buttons.dart';
import '../../constants.dart';
import '../../services/auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  final AuthService _authAnon = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        //Anon Registration
        child: Buttons(
            text: 'Anonymous',
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              dynamic result = await _authAnon.signUpAnon();
              if (result == null) {
                //print('error signing in');
                showToastError(
                    'Error signing in. \nPlease sign in again.', context);
              } else {
                //print(result.uid);
                Navigator.pushNamed(context, '/landing');
                openDialog();
                setState(() {
                  showSpinner = false;
                });
              }
            }),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.lightGreenAccent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          title: const Text(
            "Congratulations! \n\nPlease Remember",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: const Text(
            "If You sign out or uninstall AnonC, \nYou won't be able to access the same account anymore. \n\nYour information will be lost forever.",
            //textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                "OK",
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
