import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/race.dart';
import '../models/driver.dart';
import '../models/team.dart';
import '../models/result.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000/api';

  Future<List<Race>> getSchedule({String season = 'current'}) async {
    final response = await http.get(Uri.parse('$baseUrl/schedule/$season'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Race.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  Future<List<Driver>> getDrivers({String season = 'current'}) async {
    final response = await http.get(Uri.parse('$baseUrl/drivers/$season'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Driver.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }

  Future<List<Team>> getTeams({String season = 'current'}) async {
    final response = await http.get(Uri.parse('$baseUrl/teams/$season'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Team.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  Future<List<Result>> getResults(String season, String round) async {
    final response = await http.get(Uri.parse('$baseUrl/results/$season/$round'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load results');
    }
  }
}
