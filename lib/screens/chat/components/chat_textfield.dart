import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat/doctor.dart';
import 'package:rive_animation/screens/chat_bot/chat_message.dart';
import 'package:rive_animation/usesr_provider.dart';

class ChatTextfield extends ConsumerStatefulWidget {
  const ChatTextfield({super.key, required this.doctor});

  final Doctor doctor;

  @override
  ConsumerState<ChatTextfield> createState() => _ChatTextfieldState();
}

class _ChatTextfieldState extends ConsumerState<ChatTextfield> {
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            TextField(
              controller: chatController,
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                border: InputBorder.none,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: purplecolor,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () async {
                    final message =
                        ChatMessage(message: chatController.text, uid: ref.read(userProvider)?.uid ?? "", isBot: false)
                            .toJson();
                    message["created_at"] = Timestamp.now();
                    message["doctorId"] = widget.doctor.uid;
                    chatController.clear();
                    await FirebaseFirestore.instance.collection("DoctorChats").doc().set(message);
                  },
                  child: const Icon(
                    Icons.send,
                    color: backgroundColorLight,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
