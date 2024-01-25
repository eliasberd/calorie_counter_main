import 'package:calorie_counter_app_design/food.dart';
import 'package:calorie_counter_app_design/food_test.dart';
import 'package:flutter/material.dart';

class DiaryHeader extends StatelessWidget{
  final String meal;
  int calorieValue = 0;

  DiaryHeader({required this.meal, required this.calorieValue});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.redAccent,
        height: 60,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 15, right: 10),
        child:  Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 0),
                  child:
                  SizedBox(
                    width:225,
                    child: Text(meal,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 23,
                            color: Colors.white
                        )
                    )
                  ),

              ),
              Spacer(flex: 3),
              Padding(padding: EdgeInsets.only(bottom:7),
                child: IconButton(
                    color: Colors.white,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        debugPrint(meal.toString());
                        return AddFoodTest(meal:meal);
                      }

                      ));
                    },
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                )
              ),
              Spacer(flex: 6),
              Text(
                '$calorieValue',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 23,
                    color: Colors.black
                ),
              )

            ]
        )
    );


  }

}