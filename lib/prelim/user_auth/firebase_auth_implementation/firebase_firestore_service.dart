import 'package:calorie_counter_app_design/prelim/user_auth/end_user.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class FirebaseFirestoreService {
  final _firestoreDatabase = FirebaseFirestore.instance;

  // An instance of the EndUser class to store the retrieved user data.
  late EndUser endUser;

// A method to fetch user data from Firestore based on the user's email.
  Future<EndUser> getUserDataByEmail() async {
    final FirebaseAuthService auth = FirebaseAuthService();

    // Reference to the 'users' collection in Firestore.
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Perform a query to get the user with the specified email
    QuerySnapshot querySnapshot = await users
        .where('email', isEqualTo: auth.getCurrentUser().email.toString())
        .get();

    // Get the first document (assuming there is only one user with the specified email)
    var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

    // Convert the retrieved data into an EndUser object
    endUser = EndUser.fromMap(userData);

    // Return the EndUser object containing user data
    return endUser;
  }

  Future<void> addUser({
    required String email,
    required String firstName,
    required String lastName,
    String? suffix,
    required double height,
    required double weight,
    required int age,
    required String sex,
  }) async {
    DateTime dateTime = DateTime.now();
    String formattedDate =
        DateFormat('d MMMM y "at" HH:mm:ss "UTC"Z').format(dateTime);

    try {
      // Using the Firestore database instance to access the "users" collection
      Map<String, dynamic> userData = {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'height': height,
        'weight': weight,
        'age': age,
        'sex': sex,
        'dateRegistered': formattedDate,
      };

      // Include 'suffix' only if it's not null or empty
      if (suffix != null && suffix.isNotEmpty) {
        userData['suffix'] = suffix;
      }

      await _firestoreDatabase.collection("users").add(userData).then(
          (DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
    } catch (e) {
      print("Error adding user data to Firestore: $e");
    }
  }

  // A function that fetch users data
  Future<Map<String, dynamic>> getUserData() async {
    final FirebaseAuthService auth = FirebaseAuthService();

    try {
      // Get the current user
      User? user = auth.getCurrentUser();

      // Fetch additional user data from Firestore
      DocumentSnapshot userDoc =
          await _firestoreDatabase.collection("users").doc(user.uid).get();
      if (userDoc.exists) {
        // User document exists in Firestore
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        return userData;
      } else {
        // User document does not exist in Firestore
        return {};
      }
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print('Error getting user data: $e');
      }
      return {};
    }
  }
}
