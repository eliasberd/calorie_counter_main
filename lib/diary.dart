import 'dart:async';
import 'package:calorie_counter_app_design/diary_elements/diary_header.dart';
import 'package:calorie_counter_app_design/diary_elements/foodlist.dart';
import 'package:calorie_counter_app_design/firebase_realtime_services.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

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
  final StreamController<String> _dataController = StreamController<String>();
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


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          color: Colors.white,
          height: 75,
          width: 500,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Spacer(),
                const Text(
                    'Daily Goal:',
                  style: TextStyle(
                    fontFamily: "Chivo",
                    fontSize: 30
                  ),
                ),
                const Spacer(),

                StreamBuilder<String>(
                    stream: _dataController.stream,
                    builder: (context, snapshot){
                      return Text('${snapshot.data}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30
                      ),
                      );
                    }

                ),

                Visibility(visible: !hasUpdated,
                    child:
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
                    },
                      icon: const Icon(
                        Icons.restart_alt,
                        color: Colors.redAccent,
                      )
                  )
                ),
                    const Spacer()

              ]
              ),
      ),
      Column(children: <Widget>[
        DiaryHeader(meal: 'Breakfast', calorieValue: breakfastVal),
        const FoodList(meal: 'Breakfast')
      ]),
      Column(
        children: [
          Column(
            children: <Widget>[
              DiaryHeader(meal: 'Lunch', calorieValue: lunchVal),
              const FoodList(meal: 'Lunch')
            ],
          )
        ],
      ),

      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Dinner', calorieValue: dinnerVal),
          const FoodList(meal: 'Dinner')
          ]
      ),
      Column(
        children: <Widget>[
          DiaryHeader(meal: 'Snack', calorieValue: snackVal),
          const FoodList(meal: 'Snack')
            ],
          ),
      const SizedBox(height: 30,),
      ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(150, 50)),
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

        databaseReference.child('addedFood').child(currentUid).remove();

        setState(() {
          hasUpdated = false;
          breakfastVal = 0;
          lunchVal = 0;
          dinnerVal = 0;
          snackVal = 0;
          userTotalCal = 0;

        });


      }, child: const Text(
          'Reset Day',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
        ),
      )

      ),

        ],
      );
  }

}


