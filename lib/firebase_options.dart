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
    apiKey: 'AIzaSyD0MQeY3rr6X39JJruZXWG1AqI0DEkGAOA',
    appId: '1:939205999890:web:1c22f8377f0f40e60687cb',
    messagingSenderId: '939205999890',
    projectId: 'calorie-counter-d4191',
    authDomain: 'calorie-counter-d4191.firebaseapp.com',
    databaseURL: 'https://calorie-counter-d4191-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'calorie-counter-d4191.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDA89rpL7ltieoO_BQXBKh8tLzKKlcTads',
    appId: '1:939205999890:android:35a0493ac20856440687cb',
    messagingSenderId: '939205999890',
    projectId: 'calorie-counter-d4191',
    databaseURL: 'https://calorie-counter-d4191-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'calorie-counter-d4191.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuU4Ml4KuZ2xo_wnFbB8X4g7tHZTLcmRw',
    appId: '1:939205999890:ios:6f06025884c5ec130687cb',
    messagingSenderId: '939205999890',
    projectId: 'calorie-counter-d4191',
    databaseURL: 'https://calorie-counter-d4191-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'calorie-counter-d4191.appspot.com',
    androidClientId: '939205999890-mih4makb2lcgppgpg8jh0virodiuiflc.apps.googleusercontent.com',
    iosClientId: '939205999890-3j10cmn2l254561eiciucdcgkg5lpbab.apps.googleusercontent.com',
    iosBundleId: 'com.example.calorieCounterAppDesign',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuU4Ml4KuZ2xo_wnFbB8X4g7tHZTLcmRw',
    appId: '1:939205999890:ios:64f4ee188d2361470687cb',
    messagingSenderId: '939205999890',
    projectId: 'calorie-counter-d4191',
    databaseURL: 'https://calorie-counter-d4191-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'calorie-counter-d4191.appspot.com',
    androidClientId: '939205999890-mih4makb2lcgppgpg8jh0virodiuiflc.apps.googleusercontent.com',
    iosClientId: '939205999890-5c6kfmmm7rbiubuias37g4ldv1agk3g9.apps.googleusercontent.com',
    iosBundleId: 'com.example.calorieCounterAppDesign.RunnerTests',
  );
}
