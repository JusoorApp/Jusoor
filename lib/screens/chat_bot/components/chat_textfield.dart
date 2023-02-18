import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat_bot/chat_message.dart';
import 'package:rive_animation/usesr_provider.dart';

class ChatBotTextField extends ConsumerStatefulWidget {
  const ChatBotTextField({super.key});

  @override
  ConsumerState<ChatBotTextField> createState() => _ChatBotTextFieldState();
}

class _ChatBotTextFieldState extends ConsumerState<ChatBotTextField> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            TextField(
              controller: messageController,
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
              right: 10,
              top: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: purplecolor,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () async {
                    final message = ChatMessage(
                            message: messageController.text, uid: ref.read(userProvider)?.uid ?? "a", isBot: false)
                        .toJson();
                    message["created_at"] = Timestamp.now();
                    messageController.clear();
                    await FirebaseFirestore.instance.collection("chats").doc().set(message);
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
