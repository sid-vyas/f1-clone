import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/team.dart';

class TeamStandingsScreen extends StatefulWidget {
  @override
  _TeamStandingsScreenState createState() => _TeamStandingsScreenState();
}

class _TeamStandingsScreenState extends State<TeamStandingsScreen> {
  late Future<List<Team>> futureTeams;
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
    futureTeams = apiService.getTeams(season: selectedSeason);
  }

  void _onSeasonChanged(String? season) {
    if (season != null) {
      setState(() {
        selectedSeason = season;
        futureTeams = apiService.getTeams(season: season);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Standings'),
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
      body: FutureBuilder<List<Team>>(
        future: futureTeams,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No team standings found.'));
          }
          final teams = snapshot.data!;
          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return ListTile(
                title: Text(team.name),
                trailing: Text('${team.points} pts'),
              );
            },
          );
        },
      ),
    );
  }
}
