import 'package:anonc/screens/post_signup/rules.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../animated_texts.dart';
import '../pre_signup/anon_signup.dart';

import 'chat_screen.dart';
import 'chat_screen1.dart';
import 'chat_screen2.dart';
import 'chat_screen3.dart';
import 'chat_screen4.dart';

//final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      //print('The Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const AnimatedTitle(
          text: 'AnonC',
          fontSize: 25.0,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(5),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade200,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(55),
                      topLeft: Radius.circular(55),
                      bottomRight: Radius.circular(55),
                      bottomLeft: Radius.circular(55),
                    ),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            //color: Colors.blueGrey[900],
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(55),
                                topLeft: Radius.circular(55),
                                bottomRight: Radius.circular(55),
                                bottomLeft: Radius.circular(55),
                              ),
                            ),
                            child: Text(
                              'Anon - ' +
                                  loggedInUser!.uid
                                      .substring(loggedInUser!.uid.length - 5),
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.redAccent,
                            indent: 1,
                            endIndent: 1,
                          ),
                          Text(
                            'Welcome to AnonC !',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Important!',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          TextButton(
                            child: Text(
                              'Please click here to know how we function',
                              style: TextStyle(color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => const RulesScreen()),
                              );
                            },
                          ),
                          const Divider(
                            color: Colors.redAccent,
                            indent: 1,
                            endIndent: 1,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          listNames(
                              text: 'General Chat Room',
                              avatar:
                                  const AssetImage('images/masked_chat.png'),
                              onClicked: () {
                                selectedItem(context, 1);
                              }),
                          const SizedBox(
                            width: 10,
                            height: 12,
                          ),
                          listNames(
                              text: 'Political Chat Room',
                              avatar:
                                  const AssetImage('images/masked_chat.png'),
                              //Image.asset('assets/images/live_chat.png'),
                              onClicked: () {
                                selectedItem(context, 2);
                              }),
                          const SizedBox(
                            width: 10,
                            height: 12,
                          ),
                          listNames(
                              text: 'Love Chat Room',
                              avatar:
                                  const AssetImage('images/masked_chat.png'),
                              onClicked: () {
                                selectedItem(context, 3);
                              }),
                          const SizedBox(
                            width: 10,
                            height: 12,
                          ),
                          listNames(
                              text: 'Adult Chat Room',
                              avatar:
                                  const AssetImage('images/masked_chat.png'),
                              onClicked: () {
                                selectedItem(context, 4);
                              }),
                          const SizedBox(
                            width: 10,
                            height: 12,
                          ),
                          listNames(
                              text: 'Emotional Chat Room',
                              avatar:
                                  const AssetImage('images/masked_chat.png'),
                              onClicked: () {
                                selectedItem(context, 5);
                              }),
                          const SizedBox(
                            width: 10,
                            height: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listNames({
    ImageProvider? avatar,
    required String text,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      focusColor: Colors.lightGreenAccent,
      hoverColor: Colors.black87,
      leading: CircleAvatar(
        radius: 30,
        child: avatar == null
            ? CircleAvatar(
                radius: 35,
                backgroundColor: Colors.lightGreen,
                child: Text(
                  text[0].toUpperCase(),
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        backgroundColor: Colors.transparent,
        backgroundImage: avatar,
        //onBackgroundImageError: ,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.blueGrey[900],
        ),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context, rootNavigator: true).pop();

    switch (index) {
      case 0:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ));
        break;
      case 1:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ));
        break;
      case 2:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const ChatScreen1(),
        ));
        break;
      case 3:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const ChatScreen2(),
        ));
        break;
      case 4:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const ChatScreen3(),
        ));
        break;

      case 5:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const ChatScreen4(),
        ));
        break;

      case 6:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => const RegistrationScreen(),
        ));
        break;
    }
  }
}
