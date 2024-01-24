import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class FoodList extends StatefulWidget{
  @override
  String meal;
  FoodList({required this.meal});
  State<FoodList> createState() => FoodListState();

}

class FoodListState extends State<FoodList>{
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  String currentUid = FirebaseAuthService().getCurrentUserUid();


  @override
  Widget build(BuildContext context) {
    return Container(
        child: FirebaseAnimatedList(
        query: databaseReference.child('addedFood').child(currentUid).child(widget.meal),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, snapshot, index, animation){
          return ListTile(
            title: Text(
              snapshot.child('food').value.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                  fontSize: 20
              ),
            ),
            trailing: Text(
                snapshot.child('cal').value.toString(),
              style: TextStyle(
                  fontFamily: 'Chivo',
                  fontSize: 20
              ),
            ),
          );
        }
    )
    );


  }

}