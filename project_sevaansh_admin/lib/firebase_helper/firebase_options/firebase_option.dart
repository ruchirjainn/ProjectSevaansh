import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isAndroid) {
      return const FirebaseOptions(
        appId: "1:460520826934:android:8d8fc486b80c5f5b24d097",
        apiKey: "AIzaSyBN-TNFeuyIlt7i6xkxtoI75i25y25ws4k",
        projectId: "project-sevaansh",
        messagingSenderId: "107141927327",
      );
    } else {
      return const FirebaseOptions(
          appId:
              "1:460520826934:android:8d8fc486b80c5f5b24d097", //dono alag filal only android
          apiKey: "AIzaSyBN-TNFeuyIlt7i6xkxtoI75i25y25ws4k",
          projectId: "project-sevaansh",
          messagingSenderId: "107141927327",
          iosBundleId: "com.example.project_sevaansh_admin");
    }
  }
}
