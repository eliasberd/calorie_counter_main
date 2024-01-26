import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  

  Future<int?> fetchCal() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DataSnapshot snapshot = await _database.child('user/$user/bmr').get();

    if (snapshot.value != null) {
      try {
        String cal = snapshot.value.toString();
        int intValue = int.parse(cal);
        return intValue;
      } catch(e){
        return null;
      }

    }
    return null;

  }

  Future<List<int>> fetchBreakfast() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('addedFood/$user/Breakfast');
    List<int>? dataLists = [];

    for(int i = 0 ; i <= 6; i++){
      DataSnapshot snapshot = await databaseReference.child('$i').child('cal').get();
      if(snapshot.value != null){
        dataLists.add(snapshot.value as int);

      }
    }
    return dataLists;

  }

  Future<List<int>> fetchLunch() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('addedFood/$user/Lunch');
    List<int>? dataLists = [];

    for(int i = 0 ; i <= 6; i++){
      DataSnapshot snapshot = await databaseReference.child('$i').child('cal').get();
      if(snapshot.value != null){
        dataLists.add(snapshot.value as int);

      }
    }
    return dataLists;

  }

  Future<List<int>> fetchDinner() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('addedFood/$user/Dinner');
    List<int>? dataLists = [];

    for(int i = 0 ; i <= 6; i++){
      DataSnapshot snapshot = await databaseReference.child('$i').child('cal').get();
      if(snapshot.value != null){
        dataLists.add(snapshot.value as int);

      }
    }
    return dataLists;

  }

  Future<List<int>> fetchSnack() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('addedFood/$user/Snack');
    List<int>? dataLists = [];

    for(int i = 0 ; i <= 6; i++){
      DataSnapshot snapshot = await databaseReference.child('$i').child('cal').get();
      if(snapshot.value != null){
        dataLists.add(snapshot.value as int);

      }
    }
    return dataLists;

  }


}


