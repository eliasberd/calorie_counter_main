import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double boxwidth;

  DashboardCard({required this.title, required this.value, required this.icon, required this.boxwidth});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(16),
        width: boxwidth,
        child: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Chivo',
                fontSize: 15
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Chivo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
