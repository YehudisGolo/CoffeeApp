import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsSjhyFHB1c85E-vI4RIn348lBMMOZRgI',
    appId: '1:918815897135:android:9de6730637d4feea64f8da',
    messagingSenderId: '918815897135',
    projectId: 'coffee-app-c81d0',
    storageBucket: 'coffee-app-c81d0.appspot.com',
  );
}
