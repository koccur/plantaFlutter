class Water {
  int id;
  int frequency;
  int intensity;
  String lastActivity;

//  Spray spray;
  Water({this.id, this.frequency, this.intensity, this.lastActivity});

  factory Water.fromJson(Map<String, dynamic> json) {
    return Water(
        id: json['id'], frequency: json['frequency'], intensity: json['intensity'], lastActivity: json['lastActivity']);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "frequency": frequency, "intensity": intensity, "lastActivity": lastActivity};
}
