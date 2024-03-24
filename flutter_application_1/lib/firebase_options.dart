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
    apiKey: 'AIzaSyBLcsyBkA9Jx8W4S4Ef671tCFCJCLrflHQ',
    appId: '1:510636079999:web:36f0f9ce7f2658fcb5784a',
    messagingSenderId: '510636079999',
    projectId: 'medicalpayments-bd0a6',
    authDomain: 'medicalpayments-bd0a6.firebaseapp.com',
    databaseURL: 'https://medicalpayments-bd0a6-default-rtdb.firebaseio.com',
    storageBucket: 'medicalpayments-bd0a6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC20mtJQ7Fq8crGZv152evK8zENjnP-2Hc',
    appId: '1:510636079999:android:93ca62498c2288a4b5784a',
    messagingSenderId: '510636079999',
    projectId: 'medicalpayments-bd0a6',
    databaseURL: 'https://medicalpayments-bd0a6-default-rtdb.firebaseio.com',
    storageBucket: 'medicalpayments-bd0a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBN9Y5STCmiqGFQN1uBciUhjd0fONXhvCg',
    appId: '1:510636079999:ios:fc261f337dd52f50b5784a',
    messagingSenderId: '510636079999',
    projectId: 'medicalpayments-bd0a6',
    databaseURL: 'https://medicalpayments-bd0a6-default-rtdb.firebaseio.com',
    storageBucket: 'medicalpayments-bd0a6.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBN9Y5STCmiqGFQN1uBciUhjd0fONXhvCg',
    appId: '1:510636079999:ios:aeaf94c83c42f7ceb5784a',
    messagingSenderId: '510636079999',
    projectId: 'medicalpayments-bd0a6',
    databaseURL: 'https://medicalpayments-bd0a6-default-rtdb.firebaseio.com',
    storageBucket: 'medicalpayments-bd0a6.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
