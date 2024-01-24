import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpUser(
      String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Store user information in Firestore
      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'email': email,
          'username': username,
        });
      }

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

  // A function that gets the current user
  User getCurrentUser() {
    User user = _auth.currentUser!;
    return user;
  }

  String getCurrentUserUid() {
    User user = _auth.currentUser!;
    return user.uid;
  }
}
