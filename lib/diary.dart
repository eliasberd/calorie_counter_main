import 'dart:async';
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
  int? cal;
  List<int> aggCalBreakfast = [];
  String? calculatedBMR;
  String currentUid = "";
  StreamController<String> _dataController = StreamController<String>();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    setUid();
    // writeData();
    fetchCal();
    // fetchBMR();
    fetchBreakfast();

    databaseReference.child('user/$currentUid/bmr').onValue.listen((event) {
      String newData = event.snapshot.value.toString();
      _dataController.add(newData);

    });
  }

  void setUid() {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    setState(() {
      currentUid = firebaseAuthService.getCurrentUserUid();
    });
  }

  Future<void> fetchCal() async {
    FirebaseService firebaseService = FirebaseService();
    int? calData = await firebaseService.fetchCal();

    setState(() {
      cal = calData;
    });
  }

  // Future<void> fetchBMR() async{
  //   FirebaseService firebaseService = FirebaseService();
  //   String? calculatedBMRdata = await firebaseService.fetchCalcuCal();
  //
  //   setState(() {
  //     calculatedBMR = calculatedBMRdata;
  //   });
  //
  // }

  Future<void> fetchBreakfast() async{
    FirebaseService firebaseService = FirebaseService();
    List<int> aggCal = await firebaseService.fetchBreakfast();

    setState(() {
      aggCalBreakfast = aggCal;
    });
  }



  // void writeData(){
  //   databaseReference.child('user').child(currentUid).set({
  //     "bmr" : "120"
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
                StreamBuilder<String>(
                    stream: _dataController.stream,
                    builder: (context, snapshot){
                      return Text('${snapshot.data}',
                      style: TextStyle(
                        fontFamily: 'Chivo',
                        fontSize: 30
                      ),
                      );
                    }

                ),

                Spacer(),
              ]
              )
          )
      ),
      Column(children: <Widget>[
        DiaryHeader(meal: 'Breakfast', calorieValue: 100),
        FoodList(meal: 'Breakfast')
      ]),
      Column(
        children: [
          Column(
            children: <Widget>[
              DiaryHeader(meal: 'Lunch', calorieValue: 100),
              FoodList(meal: 'Lunch')
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Dinner', calorieValue: 100),
          FoodList(meal: 'Dinner')
          ]
      ),
      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Snack', calorieValue: 100),
          FoodList(meal: 'Snack')
            ],
          ),
      ElevatedButton(onPressed: (){
        print(cal);
        print(aggCalBreakfast);
      },
          child: Text('test'))
        ],
      );
  }
}
