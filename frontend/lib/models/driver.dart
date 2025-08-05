class Driver {
  final String name;
  final String constructor;
  final String points;

  Driver({required this.name, required this.constructor, required this.points});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      name: '${json['Driver']['givenName']} ${json['Driver']['familyName']}',
      constructor: json['Constructors'][0]['name'],
      points: json['points'],
    );
  }
}