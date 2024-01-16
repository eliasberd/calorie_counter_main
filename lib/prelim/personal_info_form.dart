import 'components/continue_button.dart';
import 'activity_level.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInfoForm extends StatefulWidget {
  final String userId;
  final String email;
  final String activityLevel;

  const PersonalInfoForm({
    Key? key,
    required this.userId,
    required this.email,
    required this.activityLevel,
  }) : super(key: key);

  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _suffixController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  String sex = '';

  void _handlePersonalInfoFormSubmission() async {
    // Handle the form submission logic here

    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Reference to the 'users' collection in Firestore
      final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

      // Update user information in the 'users' collection
      await users.doc(userId).update({
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'suffix': _suffixController.text,
        'height': double.parse(_heightController.text),
        'weight': double.parse(_weightController.text),
        'age': int.parse(_ageController.text),
        'sex': sex,
        'email': widget.email,
        'activityLevel': widget.activityLevel,
      });

      // Navigate to the next step in the registration process
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityLevelForm(
                onSubmit: _handleActivityLevelFormSubmission)),
      );
    } catch (e) {
      print("Error updating user data in Firestore: $e");
    }
  }

  void _handleActivityLevelFormSubmission(String selectedLevel) async {
    // Handle the form submission logic here

    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Reference to the 'users' collection in Firestore
      final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

      // Update user information in the 'users' collection
      await users.doc(userId).update({
        'activityLevel': selectedLevel,
      });
    } catch (e) {
      print("Error updating user data in Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back to the previous screen (Signup)
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Fill up your personal information',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'First Name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstNameController.text = value!;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Last Name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastNameController.text = value!;
                  },
                ),
                TextFormField(
                  controller: _suffixController,
                  decoration: InputDecoration(labelText: 'Suffix (optional)'),
                  onSaved: (value) {
                    _suffixController.text = value!;
                  },
                ),
                TextFormField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Height is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _heightController.text = value!;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Weight is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _weightController.text = value!;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ageController.text = value!;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Sex:'),
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 'Male',
                      groupValue: sex,
                      onChanged: (value) {
                        setState(() {
                          sex = value as String;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: sex,
                      onChanged: (value) {
                        setState(() {
                          sex = value as String;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 40),
                ContinueButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // All fields are valid, proceed to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityLevelForm(
                            onSubmit: (selectedLevel) =>
                                _handleActivityLevelFormSubmission(
                                    selectedLevel),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}