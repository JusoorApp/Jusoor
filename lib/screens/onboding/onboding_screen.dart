import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/home/home_screen.dart';
import 'package:rive_animation/usesr_provider.dart';

import 'components/animated_btn.dart';
import 'components/sign_in_dialog.dart';

class OnbodingScreen extends ConsumerStatefulWidget {
  const OnbodingScreen({super.key});

  @override
  ConsumerState<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends ConsumerState<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider) != null
        ? const HomePage()
        : Scaffold(
            body: Stack(
              children: [
                Positioned(
                  width: MediaQuery.of(context).size.width * 1.7,
                  left: 100,
                  bottom: 100,
                  child: Image.asset(
                    "assets/Backgrounds/Spline.png",
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: const SizedBox(),
                  ),
                ),
                const RiveAnimation.asset(
                  "assets/RiveAssets/shapes.riv",
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: const SizedBox(),
                  ),
                ),
                AnimatedPositioned(
                  top: isShowSignInDialog ? -50 : 0,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  duration: const Duration(milliseconds: 260),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: 260,
                            child: Column(
                              children: const [
                                Text(
                                  "We're Here!",
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "We are here to help you, you are not alone. Here you can find people who really cares about how do you feel.",
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 2),
                          AnimatedBtn(
                            btnAnimationController: _btnAnimationController,
                            press: () {
                              _btnAnimationController.isActive = true;

                              Future.delayed(
                                const Duration(milliseconds: 800),
                                () {
                                  setState(() {
                                    isShowSignInDialog = true;
                                  });
                                  showSignInDialog(
                                    context,
                                    onValue: (_) {
                                      setState(() {
                                        isShowSignInDialog = false;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Text(""),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
