import 'package:calorie_counter_app_design/dash.dart';
import 'package:calorie_counter_app_design/prelim/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'diary.dart';

class TabBarViewMain extends StatefulWidget {
  const TabBarViewMain({super.key});

  @override
  State<TabBarViewMain> createState() => _TabBarViewMainState();
}

class _TabBarViewMainState extends State<TabBarViewMain> {
  int _currentIndex = 0;
  final List<String> tabTitle = ["Diary", "Dashboard"];

  final List<Widget> _tabs = [
    const Tab1(),
    const Tab2(),
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
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // User pressed "Cancel"
                Navigator.of(context).pop(false);
              },
<<<<<<< HEAD
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
=======
              child: const Text('Cancel'),
>>>>>>> ecf841845b88ab3b7345fc8a55b06eeb4e300f0e
            ),
            TextButton(
              onPressed: () {
                // User pressed "Log Out"
                Navigator.of(context).pop(true);
              },
              child: const Text('Log Out'),
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
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
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
            items: const [
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
