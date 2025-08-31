import 'package:flutter/material.dart';

class TeamUtils {
  static String getTeamLogo(String teamName) {
  switch (teamName) {
    case 'Red Bull': return 'assets/images/red_bull.png';
    case 'Mercedes': return 'assets/images/mercedes.png';
    case 'McLaren': return 'assets/images/mclaren.png';
    case 'Alpine F1 Team': return 'assets/images/alpine.png';
    case 'Ferrari': return 'assets/images/ferrari.png';
    case 'Williams': return 'assets/images/williams.png';
    case 'Aston Martin': return 'assets/images/aston.png';
    case 'RB F1 Team': return 'assets/images/racing_bulls.png';
    case 'Sauber': return 'assets/images/sauber.png';
    case 'Haas F1 Team': return 'assets/images/haas.png';
    default: return 'assets/images/f1_logo.png';
  }
}

static Color getTeamColor(String teamName) {
  switch (teamName) {
    case 'Red Bull': return Colors.blue;
    case 'Mercedes': return Colors.blueGrey;
    case 'McLaren': return Colors.orange;
    case 'Alpine F1 Team': return Colors.pinkAccent;
    case 'Ferrari': return Colors.red;
    case 'Williams': return Colors.blueAccent;
    case 'Aston Martin': return Colors.green;
    case 'RB F1 Team': return Colors.lightBlueAccent;
    case 'Sauber': return Colors.lightGreen;
    case 'Haas F1 Team': return Colors.white;

    default: return Colors.black;
  }
}
}