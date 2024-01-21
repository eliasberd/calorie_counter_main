import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AddFoodTest extends StatefulWidget {
  final String meal;
  AddFoodTest({required this.meal});

  @override
  State<AddFoodTest> createState() => _AddFoodTestState();
}

class _AddFoodTestState extends State<AddFoodTest> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String currentUid = '';


  List<String> foods = [
    'Milk',
    'Tuna',
    'Helllo',
    'Meow'
  ];

  List<bool> isCheckedList = [false, false, false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUid();
  }

  void setUid(){
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    setState(() {
      currentUid = firebaseAuthService.getCurrentUserUid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Add checked items to Firebase Realtime Database
              addCheckedItemsToFirebase();
            },
          ),
        ],
      ),
      body:
      // FirebaseAnimatedList(
      //   query: databaseReference.child('food'),
      //   shrinkWrap: true,
      //   itemBuilder: (context, snapshot, index, animation){
      //     return ListTile(
      //       title: Text(
      //         snapshot.child('name').value.toString()
      //       ),
      //     );
      //   }
      //
      // )

      ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foods[index]),
            trailing: Checkbox(
              value: isCheckedList[index],
              onChanged: (value) {
                setState(() {
                  isCheckedList[index] = value!;
                });
              },
            ),
          );
        },
      ),
    );
  }

  void addCheckedItemsToFirebase() {
    for (int i = 0; i < isCheckedList.length; i++) {
      if (isCheckedList[i]) {
        // Add the checked item to Firebase Realtime Database
        databaseReference.child('addedFood').child(widget.meal).child(currentUid).push().set({
          'food': foods[i],
          'timestamp': DateTime.now().toUtc().toString(),
        });
      }
    }
  }
}