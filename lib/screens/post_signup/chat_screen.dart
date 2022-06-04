import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../home.dart';
import '../../services/auth.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import 'chat_screen1.dart';
import 'chat_screen2.dart';
import 'chat_screen3.dart';
import 'chat_screen4.dart';
import 'landing_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String messageTexts = '';
  final FirebaseAuth _authService = FirebaseAuth.instance;
  final AuthService _authLogOut = AuthService();

  // void sendMessage() async {
  //   FocusScope.of(context).unfocus();
  //
  //   await _firestore.collection('chatMessages').add({
  //     'messages': messageTexts,
  //     'name':
  //         'Anon - ' + loggedInUser.uid.substring(loggedInUser.uid.length - 5),
  //     'userEmoji': 'user emoji',
  //     'timestamp': FieldValue.serverTimestamp(),
  //   });
  //   messageTextController.clear();
  // }

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
        //print(loggedInUser.uid.substring(loggedInUser.uid.length - 5));
      }
    } catch (e) {
      //print('The Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hamburgerMenu(context),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        shadowColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                openDialog();
              }),
        ],
        centerTitle: true,
        title: const Text(
          'General Room',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MessagesStream(),
              Container(
                color: const Color(0xFFB9F6CA),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: true,
                        enableSuggestions: true,
                        decoration: kMessageTextFieldDecoration,
                        onChanged: (value) {
                          setState(() {
                            messageTexts = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.lime,
                        shape: BoxShape.circle,
                      ),
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          messageTextController.clear();
                          messageTexts.trim().isEmpty
                              ? null
                              : _firestore.collection('chatMessages').add({
                                  'messages': messageTexts,
                                  'name': 'Anon - ' +
                                      loggedInUser!.uid.substring(
                                          loggedInUser!.uid.length - 5),
                                  'userEmoji': 'user emoji',
                                  'timestamp': FieldValue.serverTimestamp(),
                                });
                          messageTextController.clear();
                          // messageTexts + loggedInUser;
                        },
                        child: Icon(
                          Icons.send_outlined,
                          size: 35,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox hamburgerMenu(BuildContext context) {
    return SizedBox(
      width: 275,
      child: Drawer(
        backgroundColor: Colors.orange[100],
        elevation: 30,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: const EdgeInsets.all(1.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.masks_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      '\n\nMy Menu \n\nAnon - ' +
                          loggedInUser!.uid
                              .substring(loggedInUser!.uid.length - 5),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            listNames(
                icon: Icons.question_answer_outlined,
                text: 'All Chat Rooms',
                onClicked: () => selectedItem(context, 0)),
            listNames(
              icon: Icons.question_answer_outlined,
              text: 'General Chat Room',
              onClicked: () => selectedItem(context, 1),
            ),
            listNames(
              icon: Icons.question_answer_outlined,
              text: 'Political Chat Room',
              onClicked: () => selectedItem(context, 2),
            ),
            listNames(
              icon: Icons.question_answer_outlined,
              text: 'Love Chat Room',
              onClicked: () => selectedItem(context, 3),
            ),
            listNames(
              icon: Icons.question_answer_outlined,
              text: 'Adult Chat Room',
              onClicked: () => selectedItem(context, 4),
            ),
            listNames(
              icon: Icons.question_answer_outlined,
              text: 'Emotional Chat Room',
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.redAccent,
              indent: 15,
              endIndent: 15,
            ),
            const SizedBox(height: 15),
            // listNames(
            //   icon: Icons.exit_to_app,
            //   text: 'Log out',
            //   onClicked: () => openDialog(),
            //   //() => openDialog(),
            //   //() => selectedItem(context, 6),
            // ),
          ],
        ),
      ),
    );
  }

  Widget listNames({
    required IconData icon,
    required String text,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      hoverColor: Colors.deepOrangeAccent,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatScreen1(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatScreen2(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatScreen3(),
        ));
        break;

      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatScreen4(),
        ));
        break;

      case 6:
        //_authLogOut.signOut();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
        break;
    }
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.lightGreenAccent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          title: const Text(
            "Are You sure you want to Log out?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          content: const Text(
            "You would not be able to see your messages again!"
            "\n\nYour messages will be lost forever.",
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                _authLogOut.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chatMessages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageHolders = [];

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orange,
              ),
            );
          } else {
            var chatMessages = snapshot.data!.docs;

            for (var message in chatMessages) {
              final messageText = message['messages'];
              final messageSender = message['name'];

              final currentUser = 'Anon - ' +
                  loggedInUser!.uid.substring(loggedInUser!.uid.length - 5);

              final currentTime = Timestamp.fromMicrosecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch);
              final time = message['timestamp'] == null
                  ? currentTime
                  : message['timestamp'] as Timestamp;

              // if (currentUser == messageSender) {
              //   //The message is from Logged In User;
              // }

              final messageHolder = MessageBubble(
                sender: messageSender,
                text: messageText,
                date: DateTime.now().subtract(const Duration(minutes: 1)),
                isME: currentUser == messageSender,
                time: time,
              );
              messageHolders.add(messageHolder);
            }

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB9F6CA),
                    //blueGrey[900],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(55),
                      topLeft: Radius.circular(55),
                    ),
                  ),
                  child: GroupedListView<MessageBubble, DateTime>(
                    padding: const EdgeInsets.all(15),
                    reverse: true,
                    //order: GroupedListOrder.DESC,
                    //padding: const EdgeInsets.only(top: 1),
                    elements: messageHolders,
                    groupBy: (element) => DateTime(
                      element.date.year,
                      element.date.month,
                      element.date.day,
                    ),
                    groupHeaderBuilder: (messages) => SizedBox(
                      height: 50,
                      child: Center(
                        child: Card(
                          color: Colors.lightBlueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              DateFormat.yMMMd().format(messages.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    physics: const BouncingScrollPhysics(),
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    itemBuilder: (context, MessageBubble messages) => messages,
                  ),
                ),
              ),
            );
          }
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final DateTime date;
  final bool isME;
  final Timestamp time;

  // ignore: use_key_in_widget_constructors
  const MessageBubble(
      {required this.text,
      required this.sender,
      required this.date,
      required this.isME,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Column(
        crossAxisAlignment:
            isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
                color: isME ? Colors.blueGrey.shade700 : Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 10),
          ),
          const SizedBox(height: 10),
          Material(
            color: isME ? Colors.lightGreenAccent[100] : Colors.brown[100],
            elevation: 10,
            borderRadius: isME
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(1),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(1),
                    topLeft: Radius.circular(30),
                  ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                text,
                style: TextStyle(
                    color: isME ? Colors.blueGrey : Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('MMM d, HH:mm a').format(time.toDate()),
            style: TextStyle(
                color: isME ? Colors.blueGrey.shade700 : Colors.black,
                fontSize: 7),
          ),
        ],
      ),
    );
  }
}
