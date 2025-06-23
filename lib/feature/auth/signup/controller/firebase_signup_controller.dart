import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stepify/feature/auth/signup/models/signup_user_model.dart';

class FirebaseSignupController {
  static Future<void> signup(SignupUserModel user) async {
    try {
      // Step 1: Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      await userCredential.user?.updateDisplayName(user.name);
      await userCredential.user?.reload();

      User? updatedUser = FirebaseAuth.instance.currentUser;
      log("User created: ${updatedUser?.emailVerified}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Email already exists.');
      } else {
        print("FirebaseAuth Error: ${e.message}");
      }
    } catch (e) {
      print("General Error: $e");
    }
  }
}
