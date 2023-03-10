// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBEpuoFLibpoagpFwQkaOA0zQstvEJ4Fz8',
    appId: '1:984793355352:web:9605fb8a8c351cdf80e62d',
    messagingSenderId: '984793355352',
    projectId: 'winnerproject-c6434',
    authDomain: 'winnerproject-c6434.firebaseapp.com',
    storageBucket: 'winnerproject-c6434.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBo82-uboYUNZ31SyQRKUY4nF-jVly0VqQ',
    appId: '1:984793355352:android:23f47c3a1efe32da80e62d',
    messagingSenderId: '984793355352',
    projectId: 'winnerproject-c6434',
    storageBucket: 'winnerproject-c6434.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkWDaH5wJfb0uVym9bjiJL-99xiZyjaUs',
    appId: '1:984793355352:ios:067fd27d449e338e80e62d',
    messagingSenderId: '984793355352',
    projectId: 'winnerproject-c6434',
    storageBucket: 'winnerproject-c6434.appspot.com',
    iosClientId: '984793355352-9303n8p6k1i184qjdqehej6g9b76estp.apps.googleusercontent.com',
    iosBundleId: 'com.example.winnerProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkWDaH5wJfb0uVym9bjiJL-99xiZyjaUs',
    appId: '1:984793355352:ios:067fd27d449e338e80e62d',
    messagingSenderId: '984793355352',
    projectId: 'winnerproject-c6434',
    storageBucket: 'winnerproject-c6434.appspot.com',
    iosClientId: '984793355352-9303n8p6k1i184qjdqehej6g9b76estp.apps.googleusercontent.com',
    iosBundleId: 'com.example.winnerProject',
  );
}
