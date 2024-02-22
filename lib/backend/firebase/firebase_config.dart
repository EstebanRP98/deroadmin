import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC_eWkPKbmP6nFv0_Xx9yaEu8pyzJkCTIQ",
            authDomain: "mercatoec.firebaseapp.com",
            projectId: "mercatoec",
            storageBucket: "mercatoec.appspot.com",
            messagingSenderId: "844241444762",
            appId: "1:844241444762:web:4d286a152e8ddde94e2423"));
  } else {
    await Firebase.initializeApp();
  }
}
