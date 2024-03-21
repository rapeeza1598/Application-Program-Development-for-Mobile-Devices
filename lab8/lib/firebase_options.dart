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
    apiKey: 'AIzaSyARnqRbWNVhoEDA51Kr8_wxEMahK0DYvss',
    appId: '1:987526046033:web:7cef70fc76eb0ffbbd3370',
    messagingSenderId: '987526046033',
    projectId: 'lab8-e903c',
    authDomain: 'lab8-e903c.firebaseapp.com',
    storageBucket: 'lab8-e903c.appspot.com',
    measurementId: 'G-270FLZN9C8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIx7kowxBbEhb6bcsSG3I_FnkO1ka5FO4',
    appId: '1:987526046033:android:bfc8cc2bbdc0497ebd3370',
    messagingSenderId: '987526046033',
    projectId: 'lab8-e903c',
    storageBucket: 'lab8-e903c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDO06wLFgv9jpPMXzM5gBF7yi_ga0SImk',
    appId: '1:987526046033:ios:d1f9179a6ecbe7e5bd3370',
    messagingSenderId: '987526046033',
    projectId: 'lab8-e903c',
    storageBucket: 'lab8-e903c.appspot.com',
    iosBundleId: 'com.example.lab8',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDO06wLFgv9jpPMXzM5gBF7yi_ga0SImk',
    appId: '1:987526046033:ios:8e9fa5e9dbb5982fbd3370',
    messagingSenderId: '987526046033',
    projectId: 'lab8-e903c',
    storageBucket: 'lab8-e903c.appspot.com',
    iosBundleId: 'com.example.lab8.RunnerTests',
  );
}
