import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async{
      return false;
    },
    child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: CustomPaint(
                painter: TrianglePainter(),
                child: const SizedBox(
                  height: 300,
                  width: 300,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Transform.rotate(
                angle: 3.14 / 2,
                child: CustomPaint(
                  painter: TrianglePainter(),
                  child: const SizedBox(
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0, -0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/CalorieCheck_logo.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Counting Calories, Achieving Wellness.\nWelcome to Calorie Check!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF93E3E),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                    ),
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Signup()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}