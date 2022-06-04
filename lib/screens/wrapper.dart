import 'package:anonc/screens/post_signup/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home.dart';
import '../models/users.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<TheUser?>(context);
    //print(currentUser?.uid);

    // Returns either Home or Chat Screen
    if (currentUser == null) {
      return const Home();
    } else {
      return const LandingScreen();
    }
    //Home();
    //ChatScreen();
  }
}
