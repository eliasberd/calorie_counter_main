import 'package:calorie_counter_app_design/tabview.dart';
import 'package:calorie_counter_app_design/prelim/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _authService = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = '';
  String username = '';
  String password = '';

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Signup(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
                  const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.red[200]),
                      labelText: 'Email Address',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.red[200]),
                      labelText: 'Username',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // Save the username
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.red[200]),
                      labelText: 'Password',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red[200],
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                    obscureText: !isPasswordVisible,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Implement login logic here;

                        // Save the form values
                        _formKey.currentState!.save();

                        try {
                          // Call the signInWithEmailAndPassword method from your service
                          UserCredential userCredential =
                              await _authService.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // If the login is successful, userCredential.user will be not null
                          if (userCredential.user != null) {
                            // Navigate to the desired page or perform other actions
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TabBarViewMain(),
                              ),
                            );
                          } else {
                            // Handle other cases where userCredential.user is null
                            print("Unexpected error: user is null");
                          }
                        } catch (e) {
                          String errorMessage =
                              'Invalid email, username or password. Please try again.';

                          // Display the error message in a dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Login Failed',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(errorMessage),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[500],
                      minimumSize: const Size(128, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const SizedBox(
                      width: 120,
                      height: 50,
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?  ",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateToSignUp(context);
                          },
                          child: const Text(
                            "Sign up.",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w200,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
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
