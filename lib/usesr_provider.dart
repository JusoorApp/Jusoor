import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User?>((ref) {
  return ref.watch(authStreamProvider).maybeWhen(
      data: (data) {
        return data;
      },
      orElse: (() => FirebaseAuth.instance.currentUser));
});

final authStreamProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.userChanges();
});
