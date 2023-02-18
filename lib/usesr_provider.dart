import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User?>((ref) {
  return ref.watch(authStreamProvider).maybeWhen(
      data: (data) {
        return data;
      },
      orElse: (() => FirebaseAuth.instance.currentUser));
});

final userName = FutureProvider<String>((ref) async {
  final user = ref.watch(userProvider);
  final userData = await FirebaseFirestore.instance.collection("Students").doc(user?.uid ?? '').get();
  return userData.data()?['name'] ?? "student";
});

final authStreamProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.userChanges();
});
