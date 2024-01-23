import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
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
        print('Error');
        return null;
      }

    }

  }

  Future<int?> fetchVarCal() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DataSnapshot snapshot = await _database.child('user/$user/varBmr').get();

    if (snapshot.value != null) {
      try {
        String cal = snapshot.value.toString();
        int intValue = int.parse(cal);
        return intValue;
      } catch(e){
        print('Error');
        return null;
      }

    }

  }

  // Future<String?> fetchCalcuCal() async {
  //   String user = firebaseAuthService.getCurrentUserUid();
  //   DataSnapshot snapshot = await _database.child('user/$user/cal').get();
  //
  //   if (snapshot.value != null) {
  //     String? cal = snapshot.value as String?;
  //     return cal;
  //   }
  //
  //   return null;
  // }

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



    // DataSnapshot snapshot = await databaseReference.get();
    // final value = snapshot.value;
    // if(value != null && snapshot.value is Map){
    //   Map<String,dynamic> dataMap = snapshot.value as Map<String, dynamic>;
    //   itemLength = dataMap.length;
    //   return itemLength;
    // }
    //   return 0;
    // }
}


