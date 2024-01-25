import 'package:calorie_counter_app_design/prelim/user_auth/end_user.dart';
import 'package:calorie_counter_app_design/prelim/user_data_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/continue_button.dart';
import 'activity_level.dart';
import 'package:flutter/material.dart';

class PersonalInfoForm extends StatefulWidget {
  final String userId;
  final String email;
  final String username;
  final String activityLevel;

  const PersonalInfoForm({
    Key? key,
    required this.userId,
    required this.email,
    required this.username,
    required this.activityLevel,
  }) : super(key: key);

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _suffixController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String sex = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Fill up your personal information',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
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
                    decoration: const InputDecoration(labelText: 'Last Name'),
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
                    decoration: const InputDecoration(labelText: 'Suffix (optional)'),
                    onSaved: (value) {
                      _suffixController.text = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
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
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
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
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
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
                  const Padding(
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
                      const Text('Male'),
                      Radio(
                        value: 'Female',
                        groupValue: sex,
                        onChanged: (value) {
                          setState(() {
                            sex = value as String;
                          });
                        },
                      ),
                      const Text('Female'),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ContinueButton(
                    onPressed: () async {
                      String userId = FirebaseAuth.instance.currentUser!.uid;

                      if (_formKey.currentState!.validate()) {
                        // All fields are valid, create an EndUser instance
                        EndUser user = EndUser(
                          userId: userId,
                          email: widget.email,
                          username: widget.username,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          suffix: _suffixController.text,
                          height: double.parse(_heightController.text),
                          weight: double.parse(_weightController.text),
                          age: int.parse(_ageController.text),
                          sex: sex,
                        );

                        // Use UserDataHandler to handle data operations
                        UserDataHandler userDataHandler = UserDataHandler();

                        // Pass the EndUser instance to handlePersonalInfoFormSubmission
                        await userDataHandler.handlePersonalInfoFormSubmission(
                          user: user,
                          email: 'email',
                          username: 'username',
                          selectedLevel: 'default',
                        );

                        // Proceed to the next page
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityLevelForm(
                              onSubmit: (selectedLevel) async {
                                // Pass the EndUser instance to handleActivityLevelFormSubmission
                                await userDataHandler
                                    .handleActivityLevelFormSubmission(
                                  selectedLevel: selectedLevel,
                                  user: user,
                                  username: widget.username,
                                  email: widget.email,
                                );
                              },
                              user: user,
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
      ),
    );
  }
}
