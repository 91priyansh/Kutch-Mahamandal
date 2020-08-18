import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
