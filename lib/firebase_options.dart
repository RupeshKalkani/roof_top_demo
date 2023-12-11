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
    apiKey: 'AIzaSyAGr2mTLkv8pG7466TNJx3ZgNoLmjSwS0U',
    appId: '1:601571570566:web:cf60aa04d2920c1a51b207',
    messagingSenderId: '601571570566',
    projectId: 'demos-f2f3e',
    authDomain: 'demos-f2f3e.firebaseapp.com',
    storageBucket: 'demos-f2f3e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC81cMctUZ1bUkCh9_JuKcNjEU29b_wQzA',
    appId: '1:601571570566:android:16ea9403a412801751b207',
    messagingSenderId: '601571570566',
    projectId: 'demos-f2f3e',
    storageBucket: 'demos-f2f3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPA_dO3SvnnuJ-9PVVh75kRwY6JjHryJI',
    appId: '1:601571570566:ios:970b5a3a98d69df651b207',
    messagingSenderId: '601571570566',
    projectId: 'demos-f2f3e',
    storageBucket: 'demos-f2f3e.appspot.com',
    androidClientId:
        '601571570566-o3uj9prt0t0brpc8jmo6nu8cgt8ghliq.apps.googleusercontent.com',
    iosBundleId: 'com.example.roofTopDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPA_dO3SvnnuJ-9PVVh75kRwY6JjHryJI',
    appId: '1:601571570566:ios:897d95edfe53bec351b207',
    messagingSenderId: '601571570566',
    projectId: 'demos-f2f3e',
    storageBucket: 'demos-f2f3e.appspot.com',
    androidClientId:
        '601571570566-o3uj9prt0t0brpc8jmo6nu8cgt8ghliq.apps.googleusercontent.com',
    iosBundleId: 'com.example.roofTopDemo.RunnerTests',
  );
}
