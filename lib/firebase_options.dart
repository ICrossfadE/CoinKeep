// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDY-TlZEv5-z6XqJcyqO2mrVVTdULqNTUA',
    appId: '1:643658638040:android:5cd13289b7f6034bf1adad',
    messagingSenderId: '643658638040',
    projectId: 'coinkeep-192c9',
    storageBucket: 'coinkeep-192c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOVlXFYIEh9-MuT0z1pM9Ck_Piv5acA2k',
    appId: '1:643658638040:ios:556a033f88f9ed36f1adad',
    messagingSenderId: '643658638040',
    projectId: 'coinkeep-192c9',
    storageBucket: 'coinkeep-192c9.appspot.com',
    androidClientId:
        '643658638040-qr18u13n5cuh5dk7tkfdcigia9cekt1r.apps.googleusercontent.com',
    iosClientId:
        '643658638040-gejdpjpgufh7uahm91h78gu04s5vb25m.apps.googleusercontent.com',
    iosBundleId: 'com.example.coinkeep',
  );
}
