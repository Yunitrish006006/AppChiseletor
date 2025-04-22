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
    apiKey: 'AIzaSyAv6ZrwR6GSwj8j2o991W3w1Ln0meFrZb0',
    appId: '1:10965259978:web:59b074263552d3e6c50633',
    messagingSenderId: '10965259978',
    projectId: 'extendableaiot',
    authDomain: 'extendableaiot.firebaseapp.com',
    storageBucket: 'extendableaiot.firebasestorage.app',
    measurementId: 'G-3R4SGS6NBE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_ZKNdEIHlWUaWIG1rX41YZPEtiQuFplM',
    appId: '1:10965259978:android:d691deb77dac374fc50633',
    messagingSenderId: '10965259978',
    projectId: 'extendableaiot',
    storageBucket: 'extendableaiot.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvskP73Vo8rAG64xCd5IToZwzlxFXHGS0',
    appId: '1:10965259978:ios:e7911d6c318d80c6c50633',
    messagingSenderId: '10965259978',
    projectId: 'extendableaiot',
    storageBucket: 'extendableaiot.firebasestorage.app',
    androidClientId: '10965259978-3ajqdcs1f3n1q7h9i0doql11b4g036r5.apps.googleusercontent.com',
    iosClientId: '10965259978-sknunjr4ktsg632i3s78mvum7qmdb0p4.apps.googleusercontent.com',
    iosBundleId: 'com.example.example',
  );

}