import 'package:flutter/material.dart';


class Course {
  final String title, description, iconSrc;
  final Color color;
  final Function? onPressed;

  Course({
    required this.title,
    required this.description,
    this.iconSrc = "assets/icons/ios.svg",
    this.color = const Color(0xFF7553F6),
    this.onPressed,
  });
}

final List<Course> courses = [
  Course(
      title: "Talk to a doctor", description: "You can now talk to one of our doctors without exposing your identity"),
  Course(
    title: "Talk to our chatbot",
    description: "You can always reach to our chatbot who will be always happy to help you!",
    iconSrc: "assets/icons/code.svg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<Course> recentCourses = [
  Course(title: "State Machine", description: ""),
  Course(
    description: "",
    title: "Animated Menu",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
  Course(title: "Flutter with Rive", description: ""),
  Course(
    description: "",
    title: "Animated Menu",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/icons/code.svg",
  ),
];
