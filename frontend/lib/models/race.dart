class Race {
  final String raceName;
  final String date;
  final String circuit;

  Race({required this.raceName, required this.date, required this.circuit});

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      raceName: json['raceName'],
      date: json['date'],
      circuit: json['Circuit']['circuitName'],
    );
  }
}
