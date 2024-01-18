import 'package:calorie_counter_app_design/prelim/user_auth/end_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataHandler {
  Future<void> handlePersonalInfoFormSubmission({
    required EndUser user,
    required String selectedLevel,
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      // Reference to the 'users' collection in Firestore
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Update user information in the 'users' collection
      await users.doc(userId).set({
        'firstname': user.firstName,
        'lastname': user.lastName,
        'suffix': user.suffix,
        'height': user.height,
        'weight': user.weight,
        'age': user.age,
        'sex': user.sex,
        'activityLevel': selectedLevel,
      });

      // If needed, you can do more with the stored data here
    } catch (e) {
      print("Error storing user data in Firestore: $e");
      // Throw an exception or handle the error as needed
      throw e;
    }
  }

  Future<void> handleActivityLevelFormSubmission({
    required String selectedLevel,
    required EndUser user,
  }) async {
    try {
      // Reference to the 'users' collection in Firestore
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Update user information in the 'users' collection
      await users.doc(user.userId).update({
        'firstname': user.firstName,
        'lastname': user.lastName,
        'suffix': user.suffix,
        'height': user.height,
        'weight': user.weight,
        'age': user.age,
        'sex': user.sex,
        'activityLevel': selectedLevel,
      });

      // If needed, you can do more with the stored data here
    } catch (e) {
      print("Error storing user data in Firestore: $e");
      // Throw an exception or handle the error as needed
      throw e;
    }
  }
}
