import 'package:calorie_counter_app_design/dash.dart';
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
    Tab2(goal: 2000, food: 1500, exercise: 300),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          tabTitle[_currentIndex],
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 28,
          )
        ),
      ),
      body: SingleChildScrollView(
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book,
            size: 40,),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard,
            size: 40),
            label: 'Dash',
          ),
        ],
      ),
    );
  }
}

