import 'package:calorie_counter_app_design/dash_elements/dashcard.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  Map<String, dynamic> userData = {};
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String currentUid = "";

  TextEditingController bmrUpdate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
    setUid();
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

    //Firestore
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (snapshot.exists) {
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>;
      });
    }

    //realtime
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child('user').child(user.uid);

    try {
      DataSnapshot dataSnapshot = await databaseReference.child('bmr').get();

      if (dataSnapshot.value != null) {
        String bmrFromRealtime = dataSnapshot.value.toString();

        setState(() {
          userData['bmr'] = bmrFromRealtime;
        });
      } else {
        print('No "bmr" found in Realtime Database');
      }
    } catch (error) {
      print('Error fetching "bmr" from Realtime Database: $error');
    }
  }

  Widget buildInfoBox(String title, String value) {
    return Container(
      constraints:BoxConstraints(
        minWidth: 300,
        maxWidth: 320
      ),
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
              fontFamily: 'Poppins',
              color: Colors.white
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Chivo',
              color: Colors.white

            ),
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
    int height = userData['height'] ?? 0;
    int weight = userData['weight'] ?? 0;
    String bmr = userData['bmr'] ?? 'N/A';


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
                'Welcome $firstname !',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(),
                  DashboardCard(
                    title: 'Your BMR',
                    value: '$bmr',
                    icon: Icons.monitor_heart,
                    boxwidth: 200,
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(110, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Edit BMR'),
                            content: TextField(
                              keyboardType: TextInputType.number,
                              controller: bmrUpdate,
                              decoration: InputDecoration(
                                hintText: '$bmr'
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                                print('Success');
                              }, child: Text(
                                  'Close'
                              )
                              ),

                              TextButton(onPressed: (){
                                String text = bmrUpdate.text;
                                try{
                                  int newBmr = int.parse(text);
                                  _databaseReference.child('user').child(currentUid).update({
                                    'bmr' : newBmr,
                                    'varBmr' : newBmr
                                  });
                                }catch(e){
                                  print('Error parsing');
                                }

                                setState(() {
                                  _getUserData();
                                });
                                bmrUpdate.clear();
                                Navigator.of(context).pop();

                                print('Success');

                              }, child: Text('Update'))
                            ],

                          );
                        });

                  },
                  child: Text(
                      'Edit',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20
                    ),
                  )
              )
            ],
          ),
        ),
        ]
        )
        ),
        Text(
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
      ],


    );

  }
}
