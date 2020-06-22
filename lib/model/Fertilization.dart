class Fertilization {
  final int id;
  final int frequency;
  final int intensity;
  final String lastActivity;

  Fertilization({this.id, this.frequency, this.intensity, this.lastActivity}) {}

  factory Fertilization.fromJson(Map<String, dynamic> json) {
    return Fertilization(
        id: json['id'],
        frequency: json['frequency'],
        intensity: json['intensity'],
        lastActivity: json['lastActivity']);
  }
  Map<String, dynamic> toJson()=>
      {
        "id": id,
        "frequency": frequency,
        "intensity": intensity,
        "lastActivity": lastActivity,
      };
}
