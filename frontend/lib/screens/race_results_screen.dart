import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/result.dart';

class RaceResultsScreen extends StatefulWidget {
  @override
  _RaceResultsScreenState createState() => _RaceResultsScreenState();
}

class _RaceResultsScreenState extends State<RaceResultsScreen> {
  String selectedSeason = '2023';
  String selectedRound = '1';

  final ApiService apiService = ApiService();
  late Future<List<Result>> futureResults;

  final List<String> seasons = [
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
  ];

  final List<String> rounds = List.generate(22, (index) => '${index + 1}'); // up to 22 rounds

  @override
  void initState() {
    super.initState();
    futureResults = apiService.getResults(selectedSeason, selectedRound);
  }

  void _onSeasonChanged(String? season) {
    if (season != null) {
      setState(() {
        selectedSeason = season;
        futureResults = apiService.getResults(selectedSeason, selectedRound);
      });
    }
  }

  void _onRoundChanged(String? round) {
    if (round != null) {
      setState(() {
        selectedRound = round;
        futureResults = apiService.getResults(selectedSeason, selectedRound);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Race Results'),
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
          DropdownButton<String>(
            value: selectedRound,
            onChanged: _onRoundChanged,
            items: rounds
                .map((r) => DropdownMenuItem(
                      child: Text(r),
                      value: r,
                    ))
                .toList(),
            underline: SizedBox(),
            icon: Icon(Icons.format_list_numbered, color: Colors.white),
            dropdownColor: Colors.blue,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<List<Result>>(
        future: futureResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found.'));
          }
          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                leading: Text(result.position),
                title: Text(result.driver),
                subtitle: Text(result.constructor),
                trailing: Text(result.time),
              );
            },
          );
        },
      ),
    );
  }
}