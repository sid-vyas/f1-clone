import 'package:flutter/material.dart';

class Team {
  final String name;
  final String points;

  Team({required this.name, required this.points});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['Constructor']['name'],
      points: json['points'],
    );
  }

  
}
