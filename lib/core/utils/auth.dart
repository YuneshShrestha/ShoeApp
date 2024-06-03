import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  // Make anonymous sign in
  static Future<User?> signInAnonymously() async {
    try {
    final auth = FirebaseAuth.instance;

      User? user = auth.currentUser;
      if (user == null) {
        UserCredential userCredential = await auth.signInAnonymously();
        user = userCredential.user;
      }
      return user;
    } catch (e) {
       rethrow;
    }
  }
  // Check if user is signed in
  static Future<bool> isSignedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}