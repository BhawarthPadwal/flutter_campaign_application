import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  /// GET CURRENT USER
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  String? get currentUserEmail => _auth.currentUser?.email;

  final Logger logger = Logger();

  /// SIGN UP WITH EMAIL AND PASSWORD

  Future<UserCredential?> signup({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      logger.i("Signup successful! User UID: ${userCredential.user?.uid}");
      return userCredential;
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
      return null;
    } catch (e) {
      logger.e("Unexpected error: $e");
      return null;
    }
  }

  /// SIGN IN WITH EMAIL AND PASSWORD

  Future<bool> signin({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logger.i("Logged in successfully! User UID: ${userCredential.user?.uid}");
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

  /// SIGN IN WITH GOOGLE

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in
      if (googleUser == null) return null;

      // Get the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

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

  /// SIGN OUT USER

  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }

      print("User signed out successfully.");
      logger.i("User signed out successfully.");
    } catch (e) {
      print("Error during sign out: $e");
      logger.e(e);
    }
  }
}
