import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/usesr_provider.dart';

class AppButtons {
  static Widget mainButton(
    String text, {
    Function? onPressed,
    double fontSize = 16,
    Color buttonColor = Colors.white,
    Color textColor = Colors.black,
    EdgeInsets padding = const EdgeInsets.all(0),
    double radius = 25,
  }) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed.call();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: buttonColor,
        elevation: 0,
        padding: padding,
      ),
      child: AppText.normalText(
        text,
        fontSize: fontSize,
        color: textColor,
        isBold: true,
      ),
    );
  }
}

class AppText {
  static Widget normalText(
    String text, {
    double fontSize = 18,
    Color color = const Color(0xff3F414E),
    bool isBold = false,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: textAlign,
    );
  }
}

class WelcomeScreen extends ConsumerWidget {
  int mode = 0;
  int stress = 0;
  int energy = 0;

  final PageController controller = PageController();
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xff8E97FD),
      body: SafeArea(
        child: PageView(controller: controller, children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/Backgrounds/welcome_screen_background_objects.svg",
                      semanticsLabel: 'A red up arrow',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Spacer(),
                    Consumer(builder: ((context, ref, child) {
                      return ref.watch(userName).when(data: ((data) {
                        return AppText.normalText(
                          "Hi $data, Welcome",
                          fontSize: 30,
                          isBold: true,
                          color: const Color(0xffFFECCC),
                        );
                      }), error: ((error, stackTrace) {
                        return AppText.normalText(
                          "Hi student, Welcome",
                          fontSize: 30,
                          isBold: true,
                          color: const Color(0xffFFECCC),
                        );
                      }), loading: (() {
                        return AppText.normalText(
                          "Hi student, Welcome",
                          fontSize: 30,
                          isBold: true,
                          color: const Color(0xffFFECCC),
                        );
                      }));
                    })),
                    AppText.normalText(
                      "to Daily Mode Check",
                      fontSize: 30,
                      color: const Color(0xffFFECCC),
                    ),
                    const SizedBox(height: 15),
                    AppText.normalText(
                      "Take one minute survey to monitor your mode.",
                      fontSize: 16,
                      color: const Color(0xffEBEAEC),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: SvgPicture.asset(
                        "assets/Backgrounds/welcome_screen_background_woman.svg",
                        semanticsLabel: 'A red up arrow',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.maxFinite,
                      child: AppButtons.mainButton(
                        "Get Started",
                        onPressed: () {
                          controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        },
                        fontSize: 14,
                        buttonColor: const Color(0xffEBEAEC),
                        textColor: const Color(0xff3F414E),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/Backgrounds/welcome_screen_background_objects.svg",
                      semanticsLabel: 'A red up arrow',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Spacer(),
                    AppText.normalText(
                      "How do you feel today?",
                      fontSize: 30,
                      isBold: true,
                      color: const Color(0xffFFECCC),
                    ),
                    const SizedBox(height: 15),
                    AppText.normalText(
                      "We really care about you. Many people around the world are ready to listen to your thoughts ",
                      fontSize: 16,
                      color: const Color(0xffEBEAEC),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            mode = 3;
                            controller.animateToPage(2,
                                duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "🥳",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            mode = 2;
                            controller.animateToPage(2,
                                duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "🙂",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            mode = 1;
                            controller.animateToPage(2,
                                duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "😢",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/Backgrounds/welcome_screen_background_objects.svg",
                      semanticsLabel: 'A red up arrow',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Spacer(),
                    AppText.normalText(
                      "How stressed are you?",
                      fontSize: 30,
                      isBold: true,
                      color: const Color(0xffFFECCC),
                    ),
                    const SizedBox(height: 15),
                    AppText.normalText(
                      "We really care about you. Many people around the world are ready to listen to your thoughts ",
                      fontSize: 16,
                      color: const Color(0xffEBEAEC),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            stress = 3;
                            controller.animateToPage(3,
                                duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "🤩",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            stress = 2;
                            controller.animateToPage(3,
                                duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "🙂",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            stress = 1;
                            controller.animateToPage(3,
                                duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "😩",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/Backgrounds/welcome_screen_background_objects.svg",
                      semanticsLabel: 'A red up arrow',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Spacer(),
                    AppText.normalText(
                      "How excited are you?",
                      fontSize: 30,
                      isBold: true,
                      color: const Color(0xffFFECCC),
                    ),
                    const SizedBox(height: 15),
                    AppText.normalText(
                      "We really care about you. Many people around the world are ready to listen to your thoughts ",
                      fontSize: 16,
                      color: const Color(0xffEBEAEC),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            energy = 3;
                            FirebaseFirestore.instance.collection("ModeChecks").doc().set({
                              'uid': ref.read(userProvider)?.uid ?? 'a',
                              'energy': energy,
                              'mode': mode,
                              'stress': stress,
                              'createdAt': Timestamp.now(),
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "🔥",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            energy = 2;
                            FirebaseFirestore.instance.collection("ModeChecks").doc().set({
                              'uid': ref.read(userProvider)?.uid ?? 'a',
                              'energy': energy,
                              'mode': mode,
                              'stress': stress,
                              'createdAt': Timestamp.now(),
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "👍🏻",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            energy = 1;
                            FirebaseFirestore.instance.collection("ModeChecks").doc().set({
                              'uid': ref.read(userProvider)?.uid ?? 'a',
                              'energy': energy,
                              'mode': mode,
                              'stress': stress,
                              'createdAt': Timestamp.now(),
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "🥶",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void onGettingStartedPressed(BuildContext context) {}
}
