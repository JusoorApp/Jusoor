import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat/components/chat_app_bar.dart';
import 'package:rive_animation/screens/chat/components/chat_element.dart';
import 'package:rive_animation/screens/chat/doctor.dart';
import 'package:rive_animation/screens/chat_bot/chat_message.dart';
import 'package:rive_animation/usesr_provider.dart';

import 'components/chat_textfield.dart';

final doctorChatProvider = StreamProvider.family<List<ChatMessage>, String>((ref, doctorId) {
  final docs = FirebaseFirestore.instance
      .collection("DoctorChats")
      .where("uid", isEqualTo: ref.read(userProvider)?.uid ?? '')
      .where("doctorId", isEqualTo: doctorId)
      .orderBy("created_at", descending: false)
      .snapshots();
  final messages = docs.map((event) => event.docs.map((e) => ChatMessage.fromJson(e.data())).toList());
  print(messages);
  return messages;
});

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(doctorChatProvider(widget.doctor.uid));

    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: ChatAppbar(
        doctor: widget.doctor,
      ),
      backgroundColor: backgroundColorLight,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 73),
        child: messages.when(
          loading: (() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Loading!"),
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
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
                                    child: Text(
                                      "No messages yet between you and ${widget.doctor.name}, type any thing.",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
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
      bottomSheet: ChatTextfield(
        doctor: widget.doctor,
      ),
    );
  }
}
