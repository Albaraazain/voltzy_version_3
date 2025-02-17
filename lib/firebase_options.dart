import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDKdGczebaxw6-Wqc4BAyePoVPfDAjvRtc',
    appId: '1:819067722029:web:2f7b40f1a6b00dcc3adba4',
    messagingSenderId: '819067722029',
    projectId: 'voltzy-3c564',
    authDomain: 'voltzy-3c564.firebaseapp.com',
    databaseURL: 'https://voltzy-3c564-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'voltzy-3c564.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKdGczebaxw6-Wqc4BAyePoVPfDAjvRtc',
    appId: '1:819067722029:android:bd9c866130ca42043adba4',
    messagingSenderId: '819067722029',
    projectId: 'voltzy-3c564',
    databaseURL: 'https://voltzy-3c564-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'voltzy-3c564.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKdGczebaxw6-Wqc4BAyePoVPfDAjvRtc',
    appId: '1:819067722029:ios:0f739c47691d059a3adba4',
    messagingSenderId: '819067722029',
    projectId: 'voltzy-3c564',
    databaseURL: 'https://voltzy-3c564-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'voltzy-3c564.firebasestorage.app',
    iosBundleId: 'com.example.voltzyVersion3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKdGczebaxw6-Wqc4BAyePoVPfDAjvRtc',
    appId: '1:819067722029:ios:6824c542ff07e92b3adba4',
    messagingSenderId: '819067722029',
    projectId: 'voltzy-3c564',
    databaseURL: 'https://voltzy-3c564-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'voltzy-3c564.firebasestorage.app',
    iosBundleId: 'com.example.voltzyVersion3',
  );
}
