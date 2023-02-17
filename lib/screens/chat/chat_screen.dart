import 'package:flutter/material.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat/components/chat_app_bar.dart';
import 'package:rive_animation/screens/chat/components/chat_element.dart';

import 'components/chat_textfield.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: ChatAppbar(),
      backgroundColor: backgroundColorLight,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 73),
        child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const SizedBox(height: 10),
                ChatElement(isSender: true, message: "Hello"),
                ChatElement(isSender: false, message: "Hi"),
                ChatElement(
                    isSender: true,
                    message:
                        "I am dying, how can i survive this pain that i am going through right now"),
                ChatElement(
                    isSender: false,
                    message:
                        "I am sorry to hear that, i hope you get better soon and this pain will go away don't you worry my child "),
                ChatElement(isSender: true, message: "Hello"),
                ChatElement(isSender: false, message: "Hi"),
                ChatElement(
                    isSender: true,
                    message:
                        "I am dying, how can i survive this pain that i am going through right now"),
                ChatElement(
                    isSender: false,
                    message:
                        "I am sorry to hear that, i hope you get better soon and this pain will go away don't you worry my child "),
                ChatElement(isSender: true, message: "Hello"),
                ChatElement(isSender: false, message: "Hi"),
                ChatElement(
                    isSender: true,
                    message:
                        "I am dying, how can i survive this pain that i am going through right now"),
                ChatElement(
                    isSender: false,
                    message:
                        "I am sorry to hear that, i hope you get better soon and this pain will go away don't you worry my child "),
              ],
            )),
      ),
      bottomSheet: const ChatTextfield(),
    );
  }
}
