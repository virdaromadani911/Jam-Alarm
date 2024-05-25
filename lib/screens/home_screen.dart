import 'package:flutter/material.dart';
import 'alarm_screen.dart';
import 'clock_screen.dart';
import 'timer_screen.dart';
import 'stopwatch_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ClockScreen(),
    AlarmScreen(),
    StopwatchScreen(),
    TimerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time), // Change icon for differentiation
            label: 'Jam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_off),
            label: 'Stopwatch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.blue), // Warna ikon ketika dipilih (aktif)
        unselectedIconTheme: IconThemeData(color: Colors.black), // Warna ikon ketika tidak dipilih (tidak aktif)
      ),
    );
  }
}
