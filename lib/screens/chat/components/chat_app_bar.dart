import 'package:flutter/material.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat/doctor.dart';
import 'package:rive_animation/screens/voice_call/voice_call_screen.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbar({super.key, required this.doctor});

  final Doctor doctor;
  @override
  Size get preferredSize => const Size.fromHeight(45);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: purplecolor,
      title: Text(doctor.name,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: backgroundColorLight, fontWeight: FontWeight.bold, fontSize: 20)),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
          )),
      actions: [
        const SizedBox(width: 73),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return const JoinChannelAudio();
              })));
            },
            child: const Icon(
              Icons.video_call,
            )),
      ],
      // ignore: prefer_const_constructors
      actionsIconTheme: IconThemeData(
        color: backgroundColorLight,
        size: 30,
      ),
    );
  }
}
