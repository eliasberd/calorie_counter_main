import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: 400,
        height: 800,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 46,
              top: 433,
              child: Container(
                width: 300,
                height: 277,
                decoration: ShapeDecoration(
                  color: Color(0xFFF4B8B8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
              ),
            ),

            //Login Button
            Positioned(
              left: 100,
              top: 515,
              child: ElevatedButton(

                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage()
                  ));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,40),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),

            //Welcome Text
            Positioned(
              left: 80,
              top: 356,
              child: SizedBox(
                width: 244,
                height: 77,
                child: Text(
                  'Counting Calories, Achieving Wellness.'
                      'Welcome to Calorie Check!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF93E3E),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),

            //Register Button
            Positioned(
              left: 100,
              top: 581,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Signup()
                  ));

                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,40),
                ),

                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),

            //Logo
            Positioned(
              left: 80,
              top: 185,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/CalorieCheck_logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            //Left Polygon Shape
            Positioned(
              left: -225.37,
              top: 139.30,
              child: Transform(
                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.77),
                child: Container(
                  width: 278.51,
                  height: 288.66,
                  decoration: BoxDecoration(color: Color(0xC9F70B0B)),
                ),
              ),
            ),

            //Right Polygon Shape
            Positioned(
              left: 425.13,
              top: -50,
              child: Transform(
                transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.79),
                child: Container(
                  width: 278.51,
                  height: 288.66,
                  decoration: BoxDecoration(color: Color(0xC9F70B0B)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

