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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBY_ece5ac4sWEI11W78FBc5BCSuMq-WHk',
    appId: '1:156765538924:web:c8033b9ffb42a8b243a649',
    messagingSenderId: '156765538924',
    projectId: 'danawatest-1ffb3',
    authDomain: 'danawatest-1ffb3.firebaseapp.com',
    storageBucket: 'danawatest-1ffb3.appspot.com',
    measurementId: 'G-YERGVP7L51',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzwTzLMDrkNxPCC4t4fKUtrbCa4Wq1W2k',
    appId: '1:156765538924:android:e8a68db65468439743a649',
    messagingSenderId: '156765538924',
    projectId: 'danawatest-1ffb3',
    storageBucket: 'danawatest-1ffb3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdsVm5g22XYWXNLMK1WNwaKItcPhd98Hw',
    appId: '1:156765538924:ios:6cd79692262a9d1943a649',
    messagingSenderId: '156765538924',
    projectId: 'danawatest-1ffb3',
    storageBucket: 'danawatest-1ffb3.appspot.com',
    iosClientId: '156765538924-vvch31tv0ia495aktvbog8pqv54evo1t.apps.googleusercontent.com',
    iosBundleId: 'com.example.danawaStore2',
  );
}