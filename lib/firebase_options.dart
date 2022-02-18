// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBiBzKyOXyDBXjKn3eDU_9Qlg-LOExUNAE',
    appId: '1:482215158647:web:576463fec3e8ccc9657772',
    messagingSenderId: '482215158647',
    projectId: 'mastermind-8677a',
    authDomain: 'mastermind-8677a.firebaseapp.com',
    storageBucket: 'mastermind-8677a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBbfFD1jju18dJmLV1etFXm5T6vyiuteA',
    appId: '1:482215158647:android:004ff02c8e5c7d42657772',
    messagingSenderId: '482215158647',
    projectId: 'mastermind-8677a',
    storageBucket: 'mastermind-8677a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsuXZ--095KS_g1wRBgyOoeWEdSeoQ4Ak',
    appId: '1:482215158647:ios:154bd148933e4d5d657772',
    messagingSenderId: '482215158647',
    projectId: 'mastermind-8677a',
    storageBucket: 'mastermind-8677a.appspot.com',
    iosClientId: '482215158647-auvm798jrvr512e3k0r2k4ihlio1u6vd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mastermind',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsuXZ--095KS_g1wRBgyOoeWEdSeoQ4Ak',
    appId: '1:482215158647:ios:154bd148933e4d5d657772',
    messagingSenderId: '482215158647',
    projectId: 'mastermind-8677a',
    storageBucket: 'mastermind-8677a.appspot.com',
    iosClientId: '482215158647-auvm798jrvr512e3k0r2k4ihlio1u6vd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mastermind',
  );
}
