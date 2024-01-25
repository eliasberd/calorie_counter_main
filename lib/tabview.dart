import 'package:calorie_counter_app_design/dash.dart';
import 'package:calorie_counter_app_design/prelim/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'diary.dart';

class TabBarViewMain extends StatefulWidget {
  @override
  _TabBarViewMainState createState() => _TabBarViewMainState();
}

class _TabBarViewMainState extends State<TabBarViewMain> {
  int _currentIndex = 0;
  final List<String> tabTitle = ["Diary", "Dashboard"];

  final List<Widget> _tabs = [
    Tab1(),
    Tab2(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _signOut() async {
    // Show a confirmation dialog
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // User pressed "Cancel"
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // User pressed "Log Out"
                Navigator.of(context).pop(true);
              },
              child: Text('Log Out'),
            ),
          ],
        );
      },
    );

    // If the user confirmed, proceed with logout
    if (confirmed == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.redAccent,
            title: Text(tabTitle[_currentIndex],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                )),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: _signOut,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: _tabs[_currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                  size: 40,
                ),
                label: 'Diary',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard, size: 40),
                label: 'Dash',
              ),
            ],
          ),
        ));
  }
}
