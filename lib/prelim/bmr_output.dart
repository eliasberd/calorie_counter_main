
import 'package:calorie_counter_app_design/prelim/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:calorie_counter_app_design/tabview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BmrOutput extends StatefulWidget {
  final String selectedLevel;
  final double calculatedBMR;

  BmrOutput({
    required this.selectedLevel,
    required this.calculatedBMR,
  });

  @override
  State<BmrOutput> createState() => _BmrOutputState();
}

class _BmrOutputState extends State<BmrOutput> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  String currentUid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUid();
  }
  void setUid() {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    setState(() {
      currentUid = firebaseAuthService.getCurrentUserUid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Congratulations!",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 76, 76),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 250, 173, 173),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Column(
                children: [
                   const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontFamily: 'Chivo',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  const Text(
                    'Your custom plan is ready and you are',
                    style: TextStyle(
                      fontFamily: 'Chivo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  const Text(
                    'one step closer to your goal weight.',
                     style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  const Text(
                    'Your daily net goal is:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.calculatedBMR} calories',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                databaseReference.child('user').child(currentUid).set({
                  "bmr" : widget.calculatedBMR,
                  'varBmr': widget.calculatedBMR
                  });
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return TabBarViewMain();
                  }),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.red[400]),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
