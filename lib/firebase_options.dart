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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAk-ysCirVaLja0FPnaoyWgsrUp8gVwLzk',
    appId: '1:196706800442:android:6ba208c904d765de46b603',
    messagingSenderId: '196706800442',
    projectId: 'kiet-ride-sharing-app',
    databaseURL: 'https://kiet-ride-sharing-app-default-rtdb.firebaseio.com',
    storageBucket: 'kiet-ride-sharing-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxaXGEO9qmY4bhGW2PnltLk34m5pCUDNg',
    appId: '1:196706800442:ios:e9bc49145f2406e046b603',
    messagingSenderId: '196706800442',
    projectId: 'kiet-ride-sharing-app',
    databaseURL: 'https://kiet-ride-sharing-app-default-rtdb.firebaseio.com',
    storageBucket: 'kiet-ride-sharing-app.appspot.com',
    iosClientId: '196706800442-02jkku84u09g3ct8m2k1m8v177pjnfnf.apps.googleusercontent.com',
    iosBundleId: 'com.example.rider',
  );
}
