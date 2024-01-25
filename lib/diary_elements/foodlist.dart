import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class FoodList extends StatefulWidget{
  final String meal;
  const FoodList({super.key, required this.meal});

  @override
  State<FoodList> createState() => FoodListState();

}

class FoodListState extends State<FoodList>{
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  String currentUid = FirebaseAuthService().getCurrentUserUid();


  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: databaseReference.child('addedFood').child(currentUid).child(widget.meal),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, snapshot, index, animation){
          return ListTile(
            title: Text(
              snapshot.child('food').value.toString(),
              style: const TextStyle(
                fontFamily: 'Poppins',
                  fontSize: 20
              ),
            ),
            trailing: Text(
                snapshot.child('cal').value.toString(),
              style: const TextStyle(
                  fontFamily: 'Chivo',
                  fontSize: 20
              ),
            ),
          );
        }
    );


  }

}