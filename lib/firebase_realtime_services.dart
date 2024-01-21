import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<String?> fetchCal() async {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    String user = firebaseAuthService.getCurrentUserUid();

    DataSnapshot snapshot = await _database.child('user/$user/cal').get();

    if (snapshot.value != null) {
      String? cal = snapshot.value as String?;
      return cal;
    }

    return null;
  }
}
