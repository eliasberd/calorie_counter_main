import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

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

  Future<String?> fetchCalcuCal() async {
    String user = firebaseAuthService.getCurrentUserUid();
    DataSnapshot snapshot = await _database.child('user/$user/cal').get();

    if (snapshot.value != null) {
      String? cal = snapshot.value as String?;
      return cal;
    }

    return null;
  }

  Future<List<int>> fetchBreakfast() async{
    List<int> dataList =[];
    String user = firebaseAuthService.getCurrentUserUid();
    DataSnapshot snapshot = await _database.child('addedFood').child('$user').child('Breakfast').get();

    if(snapshot.value != null){
      Map<dynamic,dynamic>? values = snapshot.value as Map<dynamic,dynamic>;
      values.forEach((key, value) {
        dataList.add(value);
      }
      );
      return dataList;
    }
    return [];


  }
  

}
