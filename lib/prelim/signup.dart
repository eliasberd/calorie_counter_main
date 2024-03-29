import 'package:calorie_counter_app_design/prelim/login.dart';
import 'personal_info_form.dart';
import 'user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/continue_button.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String email = '';

  String username = '';

  String password = '';

  String confirmPassword = '';

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  String selectedLevel = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String username = _usernameController.text;

    // Check if passwords match
    if (password != confirmPassword) {
      // Display the error message in a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Sign Up Failed',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text('Passwords do not match. Please check again.'),
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
      return; // Exit the method if passwords don't match
    }

    // Create a new user in Firebase Authentication
    User? user = await _auth.signUpUser(email, password, username);

    // If user is not null, the signup was successful
    if (user != null) {
      // Navigate to the next step in the registration process
      // Navigate to the PersonalInfoForm and pass user information
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalInfoForm(
            // Pass user information to PersonalInfoForm
            userId: user.uid,
            email: email,
            username: username,
            activityLevel: selectedLevel, // Pass selected activity level
          ),
        ),
      );
    } else {
      // Display the error message in a dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Sign Up Failed',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
                ' The email address is already in use by another account.'),
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
                  const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Center(
                    child: Text(
                      'Enter your credentials to continue',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
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
                    controller: _usernameController,
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
                      email = value!;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.red[200]),
                      labelText: 'Password',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      // Add suffixIcon for eye icon
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
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
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.red[200]),
                      labelText: 'Confirm Password',
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      // Add suffixIcon for eye icon
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red[200],
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm password is required';
                      } else if (confirmPassword != password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      confirmPassword = value!;
                    },
                    obscureText: !isConfirmPasswordVisible,
                  ),
                  const SizedBox(height: 40),
                  ContinueButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // All fields are valid, proceed with signup
                        _signUp(); // Wait for the signup to complete before navigating
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Log In",
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
