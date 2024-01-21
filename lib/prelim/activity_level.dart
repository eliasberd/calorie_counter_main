import 'package:calorie_counter_app_design/prelim/bmr_output.dart';
import 'package:calorie_counter_app_design/prelim/login.dart';
import 'package:calorie_counter_app_design/prelim/user_auth/end_user.dart';
import 'package:flutter/material.dart';
import 'bmr_calculator.dart';

class ActivityLevelForm extends StatefulWidget {
  final Function(String) onSubmit;
  final EndUser user; // Pass EndUser instance as a parameter

  const ActivityLevelForm({
    Key? key,
    required this.onSubmit,
    required this.user,
  }) : super(key: key);

  @override
  _ActivityLevelFormState createState() => _ActivityLevelFormState();
}

class _ActivityLevelFormState extends State<ActivityLevelForm> {
  String selectedLevel = '';

  var formKey = GlobalKey<FormState>();
  BMRCalculator calculator = BMRCalculator(); // Create an instance of BMRCalculator

  List<String> activityLevelList = [
    'Sedentary',
    'Light Exercise',
    'Moderate Exercise',
    'Active Exercise',
    'Very Active Exercise',
    'Extra Active Exercise'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Text(
                "Choose the category that best represents your average weekly activity level:",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red[200],
              ),
              child: Column(
                children: activityLevelList
                    .map(
                      (level) => RadioListTile(
                        title: Text(level),
                        value: level,
                        groupValue: selectedLevel,
                        onChanged: (value) {
                          setState(() {
                            selectedLevel = value.toString();
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 340,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  var isFormValid = formKey.currentState!.validate();
                  if (isFormValid) {
                    //calculate the BMR
                    int calculatedBMR = calculator.calculateBMR(
                      age: widget.user.age,
                      weight: widget.user.weight,
                      height: widget.user.height,
                      sex: widget.user.sex,
                      activityLevel: selectedLevel,
                     
                    );
                    // Call the onSubmit callback with selectedLevel
                    widget.onSubmit(selectedLevel);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BmrOutput(
                          selectedLevel: selectedLevel,
                          calculatedBMR: calculatedBMR.toDouble(), 
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
