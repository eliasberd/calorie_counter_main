import 'dart:io';
import 'package:calorie_counter_app_design/dash_elements/dashcard.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'camera_elements/camera.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  Map<String, dynamic> userData = {};
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  // String _profilePicturePath = 'C:/Users/espaj/AndroidProject/calorie_counter_app/assets/initial_profile_picture_path.jpg';
  String _profilePicturePath = 'assets/initial_profile_picture_path.jpg';
  String currentUid = "";
  dynamic profilePic = '';
  TextEditingController bmrUpdate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
    setUid();
    setProfPic();
  }
  void setProfPic() {
    if(_profilePicturePath == 'assets/initial_profile_picture_path.jpg') {
      setState(() {
        profilePic = const AssetImage('assets/initial_profile_picture_path.jpg');
      });
    } else{
      setState(() {
        profilePic = FileImage(File(_profilePicturePath));
      });
    }
  }

  void updateProfilePicture(String newImagePath) {
    setState(() {
      _profilePicturePath = newImagePath;
    });
  }

  void setUid() {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    setState(() {
      currentUid = firebaseAuthService.getCurrentUserUid();
    });
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    //FirebaseFirestore
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (snapshot.exists) {
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>;
      });
    }

    //realtime
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('user').child(user.uid);

    try {
      DataSnapshot dataSnapshot = await databaseReference.child('bmr').get();


      if (dataSnapshot.value != null) {
        try{
          String bmrFromRealtime = dataSnapshot.value.toString();
          int intVal = int.parse(bmrFromRealtime);
          setState(() {
            userData['bmr'] = intVal;
          });

        } catch(e){
          print("Error parse");
        }


      } else {
        print('No "bmr" found in Realtime Database');
      }
    } catch (error) {
      print('Error fetching "bmr" from Realtime Database: $error');
    }
  }

  Widget buildInfoBox(String title, String value) {
    return Container(
      constraints:const BoxConstraints(
        minWidth: 300,
        maxWidth: 320
      ),
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontFamily: 'Poppins', color: Colors.white),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20, fontFamily: 'Chivo', color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String firstname = userData['firstname'] ?? 'N/A';
    String lastname = userData['lastname'] ?? 'N/A';
    String username = userData['username'] ?? 'N/A';
    double height = userData['height'] ?? 0;
    double weight = userData['weight'] ?? 0;
    int bmr = userData['bmr'] ?? 0;

    // Build the UI
    return Column(
      children: [
        Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome $firstname!',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        DashboardCard(
                          title: 'Your BMR',
                          value: '$bmr',
                          icon: Icons.monitor_heart,
                          boxwidth: 200,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(110, 50)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Edit BMR'),
                                  content: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: bmrUpdate,
                                    decoration:
                                        InputDecoration(hintText: '$bmr'),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close')),
                                    TextButton(
                                        onPressed: () {
                                          String text = bmrUpdate.text;
                                          try {
                                            int newBmr = int.parse(text);
                                            _databaseReference
                                                .child('user')
                                                .child(currentUid)
                                                .update({
                                              'bmr': newBmr,
                                              'varBmr': newBmr
                                            });
                                          } catch (e) {
                                            print('Error parsing');
                                          }

                                          setState(() {
                                            _getUserData();
                                          });
                                          bmrUpdate.clear();
                                          Navigator.of(context).pop();

                                          print('Success');
                                        },
                                        child: const Text('Update')
                                    )
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                        ))
                  ],
                ),
              ),
            ])),

        CircleAvatar(
          radius: 100,
          backgroundImage: profilePic,
        ),
        const Text(
          'Personal Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
          ),
        ),
        // Display user information using individual info boxes
        buildInfoBox('First Name', firstname),
        buildInfoBox('Last Name', lastname),
        buildInfoBox('Username', username),
        buildInfoBox('Height', height.toString()),
        buildInfoBox('Weight', weight.toString()),
        
        ElevatedButton(onPressed: () async {
          await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CameraScreen(onPhotoTaken: updateProfilePicture,))
          );
          setProfPic();

        }, child: Text('Test Camera')
        ),
        ElevatedButton(onPressed: (){
          print(_profilePicturePath);
        }, child: Text('test'))
      ],
    );
  }
}
