import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/race.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late Future<List<Race>> futureRaces;
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
    futureRaces = apiService.getSchedule(season: selectedSeason);
  }

  void _onSeasonChanged(String? season) {
    if (season != null) {
      setState(() {
        selectedSeason = season;
        futureRaces = apiService.getSchedule(season: season);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Race Schedule'),
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
      body: FutureBuilder<List<Race>>(
        future: futureRaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No races found.'));
          }
          final races = snapshot.data!;
          return ListView.builder(
            itemCount: races.length,
            itemBuilder: (context, index) {
              final race = races[index];
              return ListTile(
                title: Text(race.raceName),
                subtitle: Text('${race.circuit} - ${race.date}'),
              );
            },
          );
        },
      ),
    );
  }
}