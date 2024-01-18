import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Return the user from the UserCredential
      return credential.user;
    } catch (e) {
      // Print the specific error message
      print("Error during sign up: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Return the user from the UserCredential
      return credential.user;
    } catch (e) {
      // Print the specific error message
      print("Error during sign in: $e");
      return null;
    }
  }

  /// Signs the current user out.
  ///
  /// This function calls the Firebase authentication service to sign out the
  /// currently authenticated user.
  ///
  /// Returns:
  ///   - A [Future<void>] representing the completion of the sign-out process.
  Future<void> signOut() async {
    // Call the Firebase authentication service to sign out the user
    await _auth.signOut();
  }

  /* Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  } */

  // A function that gets the current user
  User getCurrentUser() {
    User user = _auth.currentUser!;
    return user;
  }

  /// Initiates a password reset process by sending a reset email to the specified [email].
  /// Returns true if the email is successfully sent, false otherwise.
  Future<bool> passwordReset({required String email}) async {
    try {
      // Send password reset email using Firebase authentication
      await _auth.sendPasswordResetEmail(email: email);

      // Password reset email sent successfully
      return true;
    } on FirebaseAuthException {
      // An error occurred during password reset
      return false;
    }
  }
}
