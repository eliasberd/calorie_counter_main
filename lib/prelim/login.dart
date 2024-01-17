import 'package:calorie_counter_app_design/diary.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 400,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Back Button
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // Logo
                Positioned(
                  top: 50,
                  right: 50,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/CalorieCheck_logosimple.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                
                // Red Container
                Positioned(
                  top: 350,
                  child: Container(
                    width: 350,
                    height: 420,
                    decoration:  ShapeDecoration(
                      color: Color(0xFFF4B8B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),
                  ),
                ),
                
                // Login Text
                const Positioned(
                  top: 260,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Red Line
                Positioned(
                  top: 290,
                  child: Container(
                    width: 60,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3,
                          color: Color(0xFFF93E3E),
                        ),
                      ),
                    ),
                  ),
                ),

                // Polygon Shape
                Positioned(
                  left: -188.97,
                  top: 141.61,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.68),
                    child: Container(
                      width: 278.51,
                      height: 288.66,
                      decoration: const BoxDecoration(color: Color(0xC9F70B0B)),
                    ),
                  ),
                ),

                // Text Form fields
                Positioned(
                  top: 370,
                  child: Container(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email, color: Colors.red[200]),
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
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person, color: Colors.red[200]),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              username = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock, color: Colors.red[200]),
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
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Login Button
                Positioned(
                  top: 700,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save the form values
                        _formKey.currentState!.save();

                        print('Email: $email');
                        print('Username: $username');
                        print('Password: $password');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tab1(), // Replace with your desired page
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                // Forgot Password
                Positioned(
                  top: 680,
                  child: GestureDetector(
                    onTap: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFFF93E3E),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}