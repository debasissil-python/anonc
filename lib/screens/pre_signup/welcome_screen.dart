// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../buttons.dart';
import '../../constants.dart';
import '../../animated_texts.dart';
import '../../services/auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animateColor;
  late Animation animateLogo;

  bool showSpinner = false;
  final AuthService _authAnon = AuthService();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    animateColor = ColorTween(begin: Colors.black, end: Colors.red[900])
        .animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animateColor.value,
      body: ModalProgressHUD(
        color: Colors.blue,
        opacity: 0.3,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.orange,
        ),
        inAsyncCall: showSpinner,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Hero(
                    tag: "logo",
                    child: Image.asset(
                      'images/anon.png',
                      color: Colors.lightGreenAccent,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AnimatedTitle(
                    text: 'AnonC',
                    fontSize: 55.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  kAppInfo,
                  SizedBox(
                    height: 30,
                  ),
                  Buttons(
                      text: 'Anonymous',
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        dynamic result = await _authAnon.signUpAnon();
                        if (result == null) {
                          //print('error signing in');
                          showToastError(
                              'Error signing in. \nPlease sign in again.',
                              context);
                        } else {
                          //print(result.uid);
                          Navigator.pushNamed(context, '/landing');
                          openDialog();
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            kFuelledBy,
          ],
        ),
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
            "Welcome \n\n   Please Remember",
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
