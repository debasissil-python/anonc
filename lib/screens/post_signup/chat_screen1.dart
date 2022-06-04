import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:anonc/constants.dart';
//import '../../animated_texts.dart';
import '../../home.dart';
import '../../services/auth.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'chat_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen1 extends StatefulWidget {
  const ChatScreen1({Key? key}) : super(key: key);

  @override
  _ChatScreen1State createState() => _ChatScreen1State();
}

class _ChatScreen1State extends State<ChatScreen1> {
  final messageTextController = TextEditingController();
  String messageTexts = '';
  final FirebaseAuth _authService = FirebaseAuth.instance;
  final AuthService _authLogOut = AuthService();
  final ChatScreen _hamburgerMenu = const ChatScreen();

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
      drawer: _hamburgerMenu.createState().hamburgerMenu(context),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.orange[900],
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
          'Political Room',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.orange[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MessagesStream(),
              Container(
                color: Colors.greenAccent.shade100,
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
                              : _firestore.collection('chatMessages1').add({
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
                //selectedItem(context, 6);
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

// Widget listNames({
//   required IconData icon,
//   required String text,
//   VoidCallback? onClicked,
// }) {
//   return ListTile(
//     leading: Icon(icon),
//     title: Text(text),
//     hoverColor: Colors.deepOrangeAccent,
//     onTap: onClicked,
//   );
//}

// void selectedItem(BuildContext context, int index) {
//   Navigator.of(context).pop();
//
//   switch (index) {
//     case 0:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const LandingScreen(),
//       ));
//       break;
//     case 1:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const ChatScreen(),
//       ));
//       break;
//     case 2:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const ChatScreen1(),
//       ));
//       break;
//     case 3:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const ChatScreen2(),
//       ));
//       break;
//     case 4:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const ChatScreen3(),
//       ));
//       break;
//
//     case 5:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const ChatScreen4(),
//       ));
//       break;
//
//     case 6:
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const LoginScreen(),
//       ));
//       break;
//   }
//}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chatMessages1')
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
            var chatMessages1 = snapshot.data!.docs;

            for (var message in chatMessages1) {
              final messageText = message['messages'];
              final messageSender = message['name'];

              final currentUser = 'Anon - ' +
                  loggedInUser!.uid.substring(loggedInUser!.uid.length - 5);

              final currentTime = Timestamp.fromMicrosecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch);
              final time = message['timestamp'] == null
                  ? currentTime
                  : (message['timestamp'] as Timestamp);

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
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(55),
                      topLeft: Radius.circular(55),
                    ),
                  ),
                  child: GroupedListView<MessageBubble, DateTime>(
                    padding: const EdgeInsets.all(15),
                    reverse: true,
                    // padding: const EdgeInsets.only(top: 1),
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
            color: isME ? Colors.lightBlue[100] : Colors.lightGreenAccent[100],
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
                    color: isME ? Colors.blueGrey.shade700 : Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('MMM d y, HH:mm').format(time.toDate()),
            style: TextStyle(
                color: isME ? Colors.blueGrey.shade700 : Colors.black,
                fontSize: 7),
          ),
        ],
      ),
    );
  }
}
