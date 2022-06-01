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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWPR_U7d7l1srmTV9TzsuOKbGE4mnlwPI',
    appId: '1:875523894843:android:3d7571514a103d9699761e',
    messagingSenderId: '875523894843',
    projectId: 'aplikasihutang-e6aea',
    databaseURL: 'https://aplikasihutang-e6aea-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aplikasihutang-e6aea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3-59MQDjyXIBeIXbr4B7AHuLrUSANgDE',
    appId: '1:875523894843:ios:c567b7faf748e29b99761e',
    messagingSenderId: '875523894843',
    projectId: 'aplikasihutang-e6aea',
    databaseURL: 'https://aplikasihutang-e6aea-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aplikasihutang-e6aea.appspot.com',
    iosClientId: '875523894843-jq8mffuhb6pddqok3vpg42nu4oa8a5bv.apps.googleusercontent.com',
    iosBundleId: 'com.example.pasar',
  );
}
