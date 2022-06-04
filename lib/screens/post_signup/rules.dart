import 'package:flutter/material.dart';

import '../../animated_texts.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(55),
                                topLeft: Radius.circular(55),
                                bottomRight: Radius.circular(55),
                                bottomLeft: Radius.circular(55),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'IMPORTANT',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  'Given below are some basic guidelines for using this platform :',
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 20,
                                ),
                                const Divider(
                                  color: Colors.redAccent,
                                  indent: 50,
                                  endIndent: 50,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 20,
                                ),
                                Text(
                                  'This is an',
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Anonymous Open Chat Platform.',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  '\nHere You can share your emotions, stories, ask for suggestions, advices,',
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "while being Anonymous.",
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "\nPlease respect others and don't judge anybody. \n\nTry to be empathetic and helpful.",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "\nWe have different Chat Rooms for different emotions. "
                                  "\n\nWe will be adding more Emotional Rooms in the future.",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "\nYou cannot delete what you have posted so post responsibly.",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "\nPlease follow the Law of the Land.",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  "\nAgain Please remember this is an open chat platform, so kindly ",
                                  style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "refrain from sharing your personal data.",
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
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
}
