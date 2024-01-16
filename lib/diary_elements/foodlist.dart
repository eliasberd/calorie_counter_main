
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class FoodList extends StatefulWidget{
  @override
  State<FoodList> createState() => FoodListState();

}

class FoodListState extends State<FoodList>{

  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('addedFood');


  @override
  Widget build(BuildContext context) {
    return Container(
        child: FirebaseAnimatedList(
        query: databaseReference,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, index, animation){
          return ListTile(
            title: Text(
              snapshot.child('name').value.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                  fontSize: 25
              ),
            ),
            subtitle: Text(
                snapshot.child('cal').value.toString(),
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15
              ),
            ),
          );

        }
    )
    );


  }

}