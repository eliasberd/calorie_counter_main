import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double boxwidth;

  const DashboardCard({super.key, required this.title, required this.value, required this.icon, required this.boxwidth});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: boxwidth,
        child: Center(
          child: Column(

          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Chivo',
                fontSize: 15
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
