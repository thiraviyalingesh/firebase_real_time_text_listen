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
    apiKey: 'AIzaSyAelUva8ArxU3rhPo9ZCGcQsv61aZpPfHQ',
    appId: '1:477199306502:web:69499ab60d1740cc105887',
    messagingSenderId: '477199306502',
    projectId: 'capefluttermvvm',
    authDomain: 'capefluttermvvm.firebaseapp.com',
    storageBucket: 'capefluttermvvm.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvdK9WRMEiiuviKo0U9bJnN2lk5wbL7EE',
    appId: '1:452525487446:android:9a1c8384d03005d7da52f7',
    messagingSenderId: '452525487446',
    projectId: 'firstproject-9aff0',
    storageBucket: 'firstproject-9aff0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDJc_c-F4YkSfcEGd7sH0vJUmKz6e9hd4',
    appId: '1:169149925212:ios:215422cc4af962d2c62399',
    messagingSenderId: '169149925212',
    projectId: 'staging-cts',
    databaseURL: "https://staging-cts-default-rtdb.firebaseio.com",
    storageBucket: 'staging-cts.appspot.com',
    iosClientId:
    '169149925212-27c44u41l08f7ic44jbvukugfrmorrfu.apps.googleusercontent.com',
    iosBundleId: 'com.cts.hubemployees',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAK2bJ_qDbDZGXblQMH-9tqdE6Kkxav70w',
    appId: '1:477199306502:ios:4ba0e6d1b9bf0dd0105887',
    messagingSenderId: '477199306502',
    projectId: 'staging-cts',
    storageBucket: 'staging-cts.appspot.com',
    iosClientId:
    '477199306502-k41guofkg45de514bgmr5nq1o2it44hl.apps.googleusercontent.com',
    iosBundleId: 'com.cts.hubemployees',
  );
}
