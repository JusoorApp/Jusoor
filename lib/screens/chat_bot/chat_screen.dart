import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat/components/chat_element.dart';
import 'package:rive_animation/screens/chat_bot/chat_message.dart';
import 'package:rive_animation/screens/chat_bot/components/chat_app_bar.dart';
import 'package:rive_animation/usesr_provider.dart';

import 'components/chat_textfield.dart';

final chatBotProvider = StreamProvider<List<ChatMessage>>((ref) {
  final docs = FirebaseFirestore.instance
      .collection("chats")
      .where("uid", isEqualTo: ref.read(userProvider)?.uid ?? '')
      .orderBy("created_at", descending: false)
      .snapshots();
  final messages = docs.map((event) => event.docs.map((e) => ChatMessage.fromJson(e.data())).toList());
  return messages;
});

class ChatBotScreen extends ConsumerStatefulWidget {
  const ChatBotScreen({super.key});

  @override
  ConsumerState<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends ConsumerState<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatBotProvider);

    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: const ChatBotAppbar(),
      backgroundColor: backgroundColorLight,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 73),
        child: messages.when(
          loading: (() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Loading Eve!"),
                CircularProgressIndicator(),
              ],
            );
          }),
          error: (error, stackTrace) {
            log(error.toString());
            return const Text("Un expected error has occured!");
          },
          data: (data) {
            return SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: <Widget>[
                        const SizedBox(height: 10),
                      ] +
                      (data.isEmpty
                              ? [
                                  const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 200, left: 30, right: 30),
                                    child: Text(
                                      "Hey I'm Eve, I will be here always to help you 💙.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                        height: 1.2,
                                      ),
                                    ),
                                  ))
                                ]
                              : data.map<Widget>((element) {
                                  return ChatElement(isSender: element.isBot, message: element.message)
                                      .animate()
                                      .slideY(duration: 300.ms, begin: 1, end: 0)
                                      .fadeIn();
                                }))
                          .toList(),
                ));
          },
        ),
      ),
      bottomSheet: const ChatBotTextField(),
    );
  }
}
