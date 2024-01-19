// A class representing the End User with essential user details.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EndUser {
  final String userId;

  final String email;

  final String username;

  // User's first name.
  final String firstName;

  // User's last name.
  final String lastName;

  // User's suffix (optional).
  final String? suffix;

  // User's height.
  final double height;

  // User's weight.
  final double weight;

  // User's age.
  final int age;

  // User's sex.
  final String sex;

  // Constructor for creating an EndUser instance.
  EndUser({
    required this.userId,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.suffix,
    required this.height,
    required this.weight,
    required this.age,
    required this.sex,
  });

  // Factory method to create an EndUser instance from a map of data.
  factory EndUser.fromMap(Map<String, dynamic> map) {
    // Print a debug message indicating that data is being processed.
    print("SCANNED");

    // Create and return an EndUser instance with data from the map.
    return EndUser(
      userId: map["userId"] ?? '',
      email: map["email"] ?? '',
      username: map["username"] ?? '',
      firstName: map["firstname"] ?? '',
      lastName: map["lastname"] ?? '',
      suffix: map["suffix"],
      height: (map["height"] ?? 0.0).toDouble(),
      weight: (map["weight"] ?? 0.0).toDouble(),
      age: map["age"] ?? 0,
      sex: map["sex"] ?? '',
    );
  }
}

Future<void> handleActivityLevelFormSubmission(
    String selectedLevel, String email, String username) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  try {
    // Reference to the 'users' collection in Firestore
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    // Update user information in the 'users' collection
    await users.doc(userId).update({
      'activityLevel': selectedLevel,
      'email': email,
      'username': username,
    });
  } catch (e) {
    print("Error updating user data in Firestore: $e");
  }
}
