import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/chat/chat_screen.dart';
import 'package:rive_animation/screens/chat/doctor.dart';
import 'package:rive_animation/usesr_provider.dart';

import '../home/components/secondary_course_card.dart';

final doctorsProvider = FutureProvider<List<Doctor>>((ref) async {
  final docs = await FirebaseFirestore.instance.collection("Doctors").get();

  return docs.docs.map((e) => Doctor.fromJson(e.data())).toList();
});

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

class DoctorsScreen extends ConsumerWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Doctors",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ref.watch(doctorsProvider).when(
                loading: () {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [Text("loading"), CircularProgressIndicator()],
                  );
                },
                error: (error, stackTrace) {
                  return const Text("");
                },
                data: (data) {
                  return Column(
                    children: data.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
                                doctor: e,
                              ),
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
                          child: SecondaryCourseCard(
                            disc: "The best doctor ever",
                            title: e.name,
                            iconsSrc: '',
                            icon: Icons.healing_outlined,
                            colorl: purplecolor,
                          ).animate().slideY(duration: 400.ms).fade(duration: 400.ms),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
