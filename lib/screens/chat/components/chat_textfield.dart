import 'package:flutter/material.dart';
import 'package:rive_animation/constants.dart';

class ChatTextfield extends StatefulWidget {
  const ChatTextfield({super.key});

  @override
  State<ChatTextfield> createState() => _ChatTextfieldState();
}

class _ChatTextfieldState extends State<ChatTextfield> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Type a message",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
            border: InputBorder.none,
            suffixIcon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: purplecolor,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () {
                  //TODO: send message
                },
                child: const Icon(
                  Icons.send,
                  color: backgroundColorLight,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
