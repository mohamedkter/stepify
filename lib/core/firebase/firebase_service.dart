import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
 static Future<void> initialize() async {
   
   
   // Initialize Firebase
   await Firebase.initializeApp();
   if (kDebugMode) {
     log("Firebase initialized successfully.");
   }
 }


 // Function to check if the user is logged in
static Future<bool> isLoggedIn() async {
   try {
     User? user = FirebaseAuth.instance.currentUser;
     if (user != null) {
       if (kDebugMode) {
         log("User is logged in: ${user.email}");
       }
       return true;
     } else {
       if (kDebugMode) {
         log("No user is logged in.");
       }
       return false;
     }
   } catch (e) {
     if (kDebugMode) {
       log("Error checking login status: $e");
     }
     return false;
   }
 }

// Function to log out the user
 static Future<void> signOut() async {
   try {
     await FirebaseAuth.instance.signOut();
     if (kDebugMode) {
       log("User signed out successfully.");
     }
   } catch (e) {
     if (kDebugMode) {
       log("Error signing out: $e");
     }
   }
 }

   
   // Function to check if the email is verified
  static Future<bool> isEmailVerified() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user is currently signed in.',
        );
      }
      await user.reload(); 
      return user.emailVerified;
    } catch (e) {
      print('Error checking email verification status: $e');
      return false;  
    }
  }
}