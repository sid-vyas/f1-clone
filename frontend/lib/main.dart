import 'package:flutter/material.dart';
import 'screens/schedule_screen.dart';
import 'screens/driver_standings_screen.dart';
import 'screens/team_standings_screen.dart';
import 'screens/race_results_screen.dart';

void main() {
  runApp(F1App());
}

class F1App extends StatefulWidget {
  @override
  _F1AppState createState() => _F1AppState();
}

class _F1AppState extends State<F1App> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ScheduleScreen(),
    DriverStandingsScreen(),
    TeamStandingsScreen(),
    RaceResultsScreen(),
  ];

  final List<String> _titles = [
    'Schedule',
    'Driver Standings',
    'Team Standings',
    'Race Results',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 Mobile Clone',
      theme: ThemeData(
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/f1_logo.png'),
          title: Text('Formula 1'),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black, 
          selectedItemColor: Colors.red, 
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Drivers'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Teams'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Results'),
          ],
        ),
      ),
    );
  }
}
