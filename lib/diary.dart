import 'package:calorie_counter_app_design/diary_elements/diary_header.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {
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
            Container(padding:EdgeInsets.only(left:20, right: 20),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){},
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
                        onPressed: (){},
                        icon: Icon(Icons.keyboard_arrow_right),
                        iconSize: 35),
                ]) )

          ),
          Column(children: <Widget> [
            DiaryHeader(
                meal: 'Breakfast',
                calorieValue: 100
            ),
            
            Container(
              color: Colors.deepOrangeAccent.shade100,
              height: 150,
              child: ListView(
                itemExtent: 30,
                children: [
                  ListTile(
                    title: Text(
                      "Chicken",
                      style: TextStyle(
                        fontFamily: 'Chivo',
                        fontSize: 23,
                        color: Colors.white
                      ),
                    )
                  ),
                  ListTile(
                    title: Text(
                      'Rice',
                        style: TextStyle(
                            fontFamily: 'Chivo',
                            fontSize: 23,
                            color: Colors.white
                        )
                    ),
                  )
                ],
              ),
            )
    ]
    ),
          Column(children: [
            Column(
              children: <Widget> [
                DiaryHeader(
                    meal: 'Lunch',
                    calorieValue: 100
                ),

                Container(
                  color: Colors.deepOrangeAccent.shade100,
                  height: 150,
                  child: ListView(
                    itemExtent: 30,
                    children: [
                      ListTile(
                        title: Text(
                          'Chicken',
                          style: TextStyle(
                            fontFamily: 'Chivo',
                            fontSize: 23,
                            color: Colors.white
                          ),
                        )
                      )
                    ],
                  ),
                )
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
              Container(
                color: Colors.deepOrangeAccent.shade100,
                height: 150,
                child: ListView(
                  itemExtent: 30,
                  children: [
                    ListTile(
                      title: Text(
                        'Chicken',
                        style: TextStyle(
                          fontFamily: 'Chivo',
                          fontSize: 23,
                          color: Colors.white
                        ),
                      )
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  DiaryHeader(meal: 'Snack', calorieValue: 100),
                  Container(
                    color: Colors.deepOrangeAccent.shade100,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 5),
                    child: ListView(
                      itemExtent: 30,
                      children: [
                        ListTile(
                          title: Text(
                            'Chicken',
                            style: TextStyle(
                              fontFamily: 'Chivo',
                              fontSize: 23,
                              color: Colors.white
                            )
                          )
                        )
                      ],
                    ),
                  )
                ],
              )

            ],
          )
    ]
    );
  }
}




