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
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.only(left: 15, right: 10),
        child:  Row(
            children: [
              Padding(padding: const EdgeInsets.only(left: 0),
                  child:
                  SizedBox(
                    width:225,
                    child: Text(meal,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 23,
                            color: Colors.white
                        )
                    )
                  ),

              ),
              const Spacer(flex: 3),
              Padding(padding: const EdgeInsets.only(bottom:7),
                child: IconButton(
                    color: Colors.white,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        debugPrint(meal.toString());
                        return AddFoodTest(meal:meal);
                      }

                      ));
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                )
              ),
              const Spacer(flex: 6),
              Text(
                '$calorieValue',
                style: const TextStyle(
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