import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationController {
  // Function to send verification email
  static Future<void> sendVerificationEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (!user!.emailVerified) {
        log('Sending verification email to ${user.email}');
        user.sendEmailVerification();
      }
    } catch (e) {
      log('Error sending verification email: $e'); 
    }
  }

}
