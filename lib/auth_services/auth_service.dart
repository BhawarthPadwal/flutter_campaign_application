import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final Logger logger = Logger();

  Future<bool> signup({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      logger.i("Signup successful! User UID: ${userCredential.user?.uid}");
      return true;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "weak-password") {
        message = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with that email.";
      } else if (e.code == "invalid-email") {
        message = "The email address is invalid.";
      } else {
        message = "An unknown error occurred.";
      }
      logger.e("Signup failed: $message");
      return false;
    } catch (e) {
      logger.e("Unexpected error: $e");
      return false;
    }
  }

  Future<bool> signin({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logger.i("Signin successful! User UID: ${userCredential.user?.uid}");
      return true;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "user-not-found") {
        message = "No user found for that email.";
      } else if (e.code == "wrong-password") {
        message = "Wrong password provided for that user.";
      } else {
        message = "An unknown error occurred.";
      }
      logger.e("Signin failed: $message");
      return false;
    } catch (e) {
      logger.e("Unexpected error: $e");
      return false;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in
      if (googleUser == null) return null;

      // Get the authentication details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-In Error: $e");
      logger.e(e);
      return null;
    }
  }
}