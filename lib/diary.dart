import 'dart:async';
import 'package:calorie_counter_app_design/diary_elements/diary_header.dart';
import 'package:calorie_counter_app_design/diary_elements/foodlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget{
  @override
  State<Tab1> createState() => _Tab1State();

}

class _Tab1State extends State<Tab1> {


  @override
  void initState() {
    super.initState();
    // writeData();
  }


  // void writeData(){
  //   databaseReference.child('food').push().set({
  //     "name": "Chicken",
  //     "cal" : "hello"
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              color: Colors.white,
              height: 75,
              width: 500,
              child:
              Container(padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.keyboard_arrow_left),
                            iconSize: 35),
                        Spacer(),
                        Text("TODAY",
                            style: TextStyle(
                                fontFamily: "Chivo",
                                fontSize: 30
                            )
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.keyboard_arrow_right),
                            iconSize: 35),
                      ]))

          ),
          Column(children: <Widget>[
            DiaryHeader(
                meal: 'Breakfast',
                calorieValue: 100
            ),
            FoodList()

          ]
          ),
          Column(children: [
            Column(
              children: <Widget>[
                DiaryHeader(
                    meal: 'Lunch',
                    calorieValue: 100
                ),

              ],
            )

          ],

          ),
          Column(
            children: <Widget>[
              DiaryHeader(
                  meal: 'Dinner',
                  calorieValue: 100
              ),

              Column(
                children: <Widget>[
                  DiaryHeader(meal: 'Snack', calorieValue: 100),

                ],
              )

            ],
          )
        ]
    );
  }
}












