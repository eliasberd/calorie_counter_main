import 'package:calorie_counter_app_design/diary_elements/diary_header.dart';
import 'package:calorie_counter_app_design/diary_elements/foodlist.dart';
import 'package:calorie_counter_app_design/firebase_realtime_services.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget {
  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  String? cal;
  String currentUid = "";
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();


  @override
  void initState() {
    super.initState();
    setUid();
    fetchData();
    // writeData();
  }
  void setUid(){
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    setState(() {
      currentUid = firebaseAuthService.getCurrentUserUid();
    });
  }

  Future<void> fetchData() async{
    FirebaseService firebaseService = FirebaseService();
    String? calData = await firebaseService.fetchCal();

    setState(() {
      cal= calData;
    });
  }

  // void writeData(){
  //   databaseReference.child('user').child(currentUid).set({
  //     "cal" : "120"
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          color: Colors.white,
          height: 75,
          width: 500,
          child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(children: <Widget>[
                Text(
                    'Total Calories: ',
                  style: TextStyle(
                    fontFamily: "Chivo",
                    fontSize: 30
                  ),

                ),
                Spacer(),
                Text(cal!,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 30))
                ,
                Spacer(),
              ]
              )
          )
      ),
      Column(children: <Widget>[
        DiaryHeader(meal: 'Breakfast', calorieValue: 100),
        FoodList()
      ]),
      Column(
        children: [
          Column(
            children: <Widget>[
              DiaryHeader(meal: 'Lunch', calorieValue: 100),
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Dinner', calorieValue: 100),
          Column(
            children: <Widget>[
              DiaryHeader(meal: 'Snack', calorieValue: 100),
            ],
          )
        ],
      )
    ]);
  }
}
