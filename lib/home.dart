import 'package:anonc/screens/post_signup/chat_screen.dart';
import 'package:anonc/screens/post_signup/landing_screen.dart';
import 'package:anonc/screens/post_signup/rules.dart';
import 'package:anonc/screens/pre_signup/welcome_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const WelcomeScreen(),
      //'/registration': (context) => const RegistrationScreen(),
      //'/emailRegistration': (context) => const EmailRegistration(),
      //'/login': (context) => const LoginScreen(),
      '/chat': (context) => const ChatScreen(),
      '/landing': (context) => const LandingScreen(),
      '/rules': (context) => const RulesScreen(),
    });
  }
}
