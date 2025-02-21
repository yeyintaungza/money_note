import 'package:flutter/material.dart';

import 'calendar/ui/calendar.dart';
import 'input/ui/input.dart';
import 'other/ui/other.dart';
import 'report/ui/report.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // by default start up page is 0 ( first page)
  int _selectedIndex = 0;

  // array of widget for pages
  final List<Widget> _pages = [
    const InputPage(),
    const CalendarPage(),
    const ReportPage(),
    const OtherPage(),
  ];

  // change the index (page as well)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Set the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // diplay page of current index
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,

        currentIndex: _selectedIndex, // Track selected index
        onTap: _onItemTapped, // change the index on tap

        // just the icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Other',
          ),
        ],
      ),
    );
  }
}
