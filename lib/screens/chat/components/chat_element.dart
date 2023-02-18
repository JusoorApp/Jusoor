import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive_animation/constants.dart';

class ChatElement extends StatelessWidget {
  bool isSender = true;
  String message = "";

  ChatElement({
    super.key,
    required this.isSender,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // if (isSender) {
    //   chatColor = purplecolorLight;
    //   mainAxisAlignment = MainAxisAlignment.end;
    // } else {
    //   chatColor = purplecolor;
    //   mainAxisAlignment = MainAxisAlignment.start;
    // }
    return Padding(
      padding: EdgeInsets.only(
          left: isSender ? 0 : 10, right: isSender ? 10 : 0, top: 10),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isSender ? purplecolorLight : purplecolor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(message,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: backgroundColorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
            ),
          )
        ],
      ),
    );
  }
}
