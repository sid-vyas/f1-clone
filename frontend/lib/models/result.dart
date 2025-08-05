class Result {
  final String position;
  final String driver;
  final String constructor;
  final String time;

  Result({
    required this.position,
    required this.driver,
    required this.constructor,
    required this.time,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      position: json['position'],
      driver: '${json['Driver']['givenName']} ${json['Driver']['familyName']}',
      constructor: json['Constructor']['name'],
      time: json['Time'] != null ? json['Time']['time'] : 'N/A',
    );
  }
}