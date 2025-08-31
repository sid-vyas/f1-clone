import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/driver.dart';
import '../utils/team_utils.dart';


class DriverStandingsScreen extends StatefulWidget {
  @override
  _DriverStandingsScreenState createState() => _DriverStandingsScreenState();
}

class _DriverStandingsScreenState extends State<DriverStandingsScreen> {
  late Future<List<Driver>> futureDrivers;
  String selectedSeason = 'current';

  final ApiService apiService = ApiService();

  final List<String> seasons = [
    'current',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
  ];

  @override
  void initState() {
    super.initState();
    futureDrivers = apiService.getDrivers(season: selectedSeason);
  }

  void _onSeasonChanged(String? season) {
    if (season != null) {
      setState(() {
        selectedSeason = season;
        futureDrivers = apiService.getDrivers(season: season);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Standings'),
        actions: [
          DropdownButton<String>(
            value: selectedSeason,
            onChanged: _onSeasonChanged,
            items: seasons
                .map((s) => DropdownMenuItem(
                      child: Text(s.toUpperCase()),
                      value: s,
                    ))
                .toList(),
            underline: SizedBox(),
            icon: Icon(Icons.calendar_today, color: Colors.white),
            dropdownColor: Colors.blue,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<List<Driver>>(
        future: futureDrivers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No driver standings found.'));
          }
          final drivers = snapshot.data!;
          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    tileColor: TeamUtils.getTeamColor(driver.constructor),
                    leading: Image.asset(TeamUtils.getTeamLogo(driver.constructor)),
                    title: Text(driver.name, style: TextStyle(fontWeight: FontWeight.bold,)),
                    subtitle: Text('${driver.constructor}'),
                    trailing: Text('${driver.points} pts', style: TextStyle(fontWeight: FontWeight.bold,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
