import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  ContinueButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Container(
        width: 120, // Set button width
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.red[500],
            minimumSize: Size(128, 30), // Set button width and height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0), // Set border radius
            ),
          ),
          child: Container(
            width: 120, // Set button width
            height: 50,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}