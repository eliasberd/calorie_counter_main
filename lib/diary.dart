import 'dart:async';
import 'package:calorie_counter_app_design/diary_elements/diary_header.dart';
import 'package:calorie_counter_app_design/diary_elements/foodlist.dart';
import 'package:calorie_counter_app_design/firebase_realtime_services.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget {
  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  int cal = 0;
  int newCal = 0;
  bool hasUpdated = false;
  List<int> aggCalBreakfast = [];
  List<int> aggCalLunch = [];
  List<int> aggCalDinner = [];
  List<int> aggCalSnack = [];
  List<int> aggCalTotal = [];
  String currentUid = "";
  int breakfastVal = 0;
  int lunchVal = 0;
  int dinnerVal = 0;
  int snackVal = 0;
  int userTotalCal = 0;
  StreamController<String> _dataController = StreamController<String>();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    setUid();
    fetchCal();
    fetchBreakfast();
    fetchLunch();
    fetchDinner();
    fetchSnack();

    databaseReference.child('user/$currentUid/varBmr').onValue.listen((event) {
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
    int calData = await firebaseService.fetchCal() as int;

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
      addAggBfast(aggCalBreakfast);
    });
  }

  Future<void> fetchLunch() async{
    FirebaseService firebaseService = FirebaseService();
    List<int> aggCal = await firebaseService.fetchLunch();

    setState(() {
      aggCalLunch = aggCal;
      addAggLunch(aggCalLunch);
    });
  }

  Future<void> fetchDinner() async{
    FirebaseService firebaseService = FirebaseService();
    List<int> aggCal = await firebaseService.fetchDinner();

    setState(() {
      aggCalDinner = aggCal;
      addAggDinner(aggCalDinner);
    });
  }

  Future<void> fetchSnack() async{
    FirebaseService firebaseService = FirebaseService();
    List<int> aggCal = await firebaseService.fetchSnack();

    setState(() {
      aggCalSnack = aggCal;
      addAggSnack(aggCalSnack);

    });
  }


  void addAggBfast(List<int> list){
    int sum = 0;
    for(int i = 0; i < list.length; i++){
      sum += list[i];
  }
    setState(() {
      breakfastVal = sum;
      totalCal(breakfastVal);
    });
}

  void addAggLunch(List<int> list){
    int sum = 0;
    for(int i = 0; i < list.length; i++){
      sum += list[i];
    }
    setState(() {
      lunchVal = sum;
      totalCal(lunchVal);
    });
  }

  void addAggDinner(List<int> list){
    int sum = 0;
    for(int i = 0; i < list.length; i++){
      sum += list[i];
    }
    setState(() {
      dinnerVal = sum;
      totalCal(dinnerVal);
    });
  }

  void addAggSnack(List<int> list){
    int sum = 0;
    for(int i = 0; i < list.length; i++){
      sum += list[i];
    }
    setState(() {
      snackVal = sum;
      totalCal(snackVal);
    });
  }

  void totalCal(int sum){
    int totalCal = 0;
    aggCalTotal.add(sum);
    for(int i = 0; i < aggCalTotal.length; i ++){
      totalCal += aggCalTotal[i];
    }
    setState(() {
      userTotalCal = totalCal;
    });
  }

  void decCal(int sum){
    int decCal = cal;
    decCal = decCal-sum;

    setState(() {
      newCal = decCal;
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
              padding: EdgeInsets.only(left: 70, right: 25),
              child: Row(children: <Widget>[
                Text(
                    'Daily Goal: ',
                  style: TextStyle(
                    fontFamily: "Chivo",
                    fontSize: 30
                  ),

                ),
                StreamBuilder<String>(
                    stream: _dataController.stream,
                    builder: (context, snapshot){
                      return Text('${snapshot.data}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30
                      ),
                      );
                    }

                ),

                Spacer(),
                IconButton(onPressed: (){
                  if(!hasUpdated){
                    if(userTotalCal <= cal){
                      decCal(userTotalCal);
                    } else{
                      setState(() {
                        newCal = 0;
                      });
                    }

                    databaseReference.child('user').child(currentUid).update({
                      'varBmr': newCal
                    });

                    setState(() {
                      hasUpdated = true;

                    });
                  }
                  
                }, icon: Icon(Icons.restart_alt))
              ]
              )
          )
      ),
      Column(children: <Widget>[
        DiaryHeader(meal: 'Breakfast', calorieValue: userTotalCal),
        FoodList(meal: 'Breakfast')
      ]),
      Column(
        children: [
          Column(
            children: <Widget>[
              DiaryHeader(meal: 'Lunch', calorieValue: lunchVal),
              FoodList(meal: 'Lunch')
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Dinner', calorieValue: dinnerVal),
          FoodList(meal: 'Dinner')
          ]
      ),
      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Snack', calorieValue: snackVal),
          FoodList(meal: 'Snack')
            ],
          ),
      SizedBox(height: 30,),
      ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(150, 40)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
          onPressed: (){
        databaseReference.child('user').child(currentUid).update({
          'varBmr':cal
        });

        databaseReference.child('addedFood').child(currentUid).remove().then((_){
          print('Remove objects');
        });

        setState(() {
          hasUpdated = false;
          breakfastVal = 0;
          lunchVal = 0;
          dinnerVal = 0;
          snackVal = 0;
          userTotalCal = 0;

        });



      }, child: Text(
          'Reset Day',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
        ),
      )
      ),
      // ElevatedButton(onPressed: (){
      //   print('----------------------------');
      //   print(cal);
      //   print(aggCalBreakfast);
      //   print(aggCalLunch);
      //   print(aggCalDinner);
      //   print(aggCalSnack);
      //   print(breakfastVal);
      //   print(lunchVal);
      //   print(dinnerVal);
      //   print(snackVal);
      //   print(aggCalTotal);
      //   print(userTotalCal);
      //   print(newCal);
      //
      //   print('----------------------------');
      //
      // },
      //
      //     child: Text('test'))
        ],
      );
  }

}


