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
    apiKey: 'AIzaSyA3GMmsJSkz_5_9Bi2ooxOPd7ibFNYMF8Y',
    appId: '1:57367181651:web:0aba0e19d4ff1f83d309a6',
    messagingSenderId: '57367181651',
    projectId: 'agenda-pastoral-2906d',
    authDomain: 'agenda-pastoral-2906d.firebaseapp.com',
    storageBucket: 'agenda-pastoral-2906d.appspot.com',
    measurementId: 'G-VW5FJTXKWZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAtOvu80-TrWjHh-i3OoCpifrYoa2rUOw',
    appId: '1:57367181651:android:f66b63babfdc00dbd309a6',
    messagingSenderId: '57367181651',
    projectId: 'agenda-pastoral-2906d',
    storageBucket: 'agenda-pastoral-2906d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCScrFjDrs-R3U4MjfB0irXWjlFVtHs2E4',
    appId: '1:57367181651:ios:22e40ad858e14346d309a6',
    messagingSenderId: '57367181651',
    projectId: 'agenda-pastoral-2906d',
    storageBucket: 'agenda-pastoral-2906d.appspot.com',
    iosBundleId: 'com.example.agendaPastoraApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCScrFjDrs-R3U4MjfB0irXWjlFVtHs2E4',
    appId: '1:57367181651:ios:fe1c94ac2a91140bd309a6',
    messagingSenderId: '57367181651',
    projectId: 'agenda-pastoral-2906d',
    storageBucket: 'agenda-pastoral-2906d.appspot.com',
    iosBundleId: 'com.example.agendaPastoraApp.RunnerTests',
  );
}
