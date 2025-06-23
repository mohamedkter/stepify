import 'package:firebase_auth/firebase_auth.dart';


class FirebaseSigninController{
  /// It includes methods for signing in with email and password, as well as Google sign-in.
  static Future<void> signInWithEmail(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((userCredential) {
      // User signed in successfully
      print("User signed in: ${userCredential.user?.email}");
    }).catchError((error) {
      // Handle error
      print("Error signing in: $error");
    });
  }

  void signInWithGoogle() {
  }
}