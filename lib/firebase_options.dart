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
    apiKey: 'AIzaSyDYBgJbGptzVhRrZNrszeWhkQgzOfc3Cco',
    appId: '1:731942545884:web:632b6e61236ded30fe8719',
    messagingSenderId: '731942545884',
    projectId: 'attendance-3485d',
    authDomain: 'attendance-3485d.firebaseapp.com',
    storageBucket: 'attendance-3485d.appspot.com',
    measurementId: 'G-5NM3MZCMYM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQg4d4-cw8rNVRSY5a9mqbza5oG77tXJ4',
    appId: '1:731942545884:android:56fff8768c304211fe8719',
    messagingSenderId: '731942545884',
    projectId: 'attendance-3485d',
    storageBucket: 'attendance-3485d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQEAg1seNEY8wd7s-aPSxWxv5SEYkTHKw',
    appId: '1:731942545884:ios:61e1b29e139a5114fe8719',
    messagingSenderId: '731942545884',
    projectId: 'attendance-3485d',
    storageBucket: 'attendance-3485d.appspot.com',
    iosBundleId: 'com.example.attendance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQEAg1seNEY8wd7s-aPSxWxv5SEYkTHKw',
    appId: '1:731942545884:ios:f11dc7f77e39fde3fe8719',
    messagingSenderId: '731942545884',
    projectId: 'attendance-3485d',
    storageBucket: 'attendance-3485d.appspot.com',
    iosBundleId: 'com.example.attendance.RunnerTests',
  );
}
