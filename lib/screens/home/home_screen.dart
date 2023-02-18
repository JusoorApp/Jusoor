import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_animation/usesr_provider.dart';

import '../../model/course.dart';
import 'components/course_card.dart';
import 'components/mode_bar.dart';
import 'components/secondary_course_card.dart';
import 'mditation_screen/meditation_screen.dart';

final avgProvider = FutureProvider<double>((ref) async {
  final docs = await FirebaseFirestore.instance
      .collection("ModeChecks")
      .where('uid', isEqualTo: ref.read(userProvider)?.uid ?? '')
      .get();
  int count = 0;
  num total = 0;

  for (var element in docs.docs) {
    count++;
    total += element.data()['energy'];
    total += element.data()['stress'];
    total += element.data()['mode'];
  }

  return total / count;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Consumer(builder: ((context, ref, child) {
                          return ref.watch(userName).when(
                            loading: () {
                              return const Text("");
                            },
                            error: (error, stackTrace) {
                              return Text(
                                "student",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                              );
                            },
                            data: (data) {
                              return Text(
                                "$data!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                              );
                            },
                          );
                        })),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Icon(Icons.logout_outlined),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courses
                      .map(
                        (course) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CourseCard(
                            title: course.title,
                            discription: course.description,
                            iconSrc: course.iconSrc,
                            color: course.color,
                          ).animate().slideX(duration: 500.ms).fade(duration: 500.ms),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "More",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ...[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ModeBar(
                    ref.watch(avgProvider).when(
                        data: ((data) => 0.4),
                        error: ((error, stackTrace) {
                          return 0;
                        }),
                        loading: (() => 0)),
                  ),
                ).animate().slideY(duration: 400.ms).fade(duration: 400.ms),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                    },
                    child: const SecondaryCourseCard(
                      disc: "Short 1 minute mode check",
                      title: "Daily Mode Check",
                      iconsSrc: '',
                      icon: Icons.health_and_safety,
                      colorl: Colors.purple,
                    ).animate().slideY(duration: 400.ms).fade(duration: 400.ms),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
