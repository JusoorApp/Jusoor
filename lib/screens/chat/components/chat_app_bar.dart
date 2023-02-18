import 'package:flutter/material.dart';
import 'package:rive_animation/constants.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(45);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        elevation: 0,
        backgroundColor: purplecolor,
        title: Text("Nawaf",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: backgroundColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            )),
        actions: [
          const SizedBox(width: 73),
          GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.video_call,
              )),
        ],
        // ignore: prefer_const_constructors
        actionsIconTheme: IconThemeData(
          color: backgroundColorLight,
          size: 30,
        ),
      ),
    );
  }
}
