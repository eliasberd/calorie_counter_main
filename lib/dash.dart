import 'package:calorie_counter_app_design/dash_elements/actcard.dart';
import 'package:calorie_counter_app_design/dash_elements/dashcard.dart';
import 'package:flutter/material.dart';

class Tab2 extends StatelessWidget{
  final int goal;
  final int food;
  final int exercise;

 Tab2({
    required this.goal,
    required this.food,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    int remainingCalories = goal - food + exercise;
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            Text(
              'Calories',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25,
              ),
            ),
            Spacer(),
            Text(
              'Remaining = Goal - Food + Exercise',
              style: TextStyle(
                fontFamily: 'Chivo',
                fontSize: 12
              ),
            )
          ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            DashboardCard(
                title: 'Remaining',
                value: '$remainingCalories',
                icon: Icons.restaurant_menu,
                boxwidth: 390
            ),


            Spacer(),
          ],
        ),
        Row(
        children: [
          Spacer(),
          DashboardCard(
              title: 'Goal',
              value: '$goal',
              icon: Icons.star,
              boxwidth: 120
          ),
          DashboardCard(
              title: 'Food',
              value: '$food',
              icon: Icons.food_bank,
              boxwidth: 120
          ),

          DashboardCard(
            title: 'Exercise',
            value: '$exercise',
            icon: Icons.directions_run,
              boxwidth: 120
          ),
          Spacer(),

        ],

        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // ListView(
        //     itemExtent: 2,
        //     children: [
        //       ActivityCard(
        //         title: 'New Order',
        //         subtitle: 'John Doe placed a new order',
        //         time: '10:30 AM',
        //       ),
        //       ActivityCard(
        //         title: 'Product Update',
        //         subtitle: 'Product XYZ is now available',
        //         time: '11:15 AM',
        //       ),
        //       // Add more activity cards as needed
        //     ],
        //   ),
      ],
    );
  }
}
