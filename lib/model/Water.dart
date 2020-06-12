import 'Spray.dart';

class Water{
  final int id;
  final int frequency;
  final int intensity;
  final String lastActivity;
  final Spray spray;
  Water({this.id, this.frequency, this.intensity, this.lastActivity, this.spray}){

  }

  factory Water.fromJson(Map<String, dynamic> json) {
    return Water(
        id: json['id'],
        frequency: json['frequency'],
        intensity: json['intensity'],
        lastActivity: json['lastActivity'],
        spray: Spray.fromJson(json['spray'])
    );
  }
}
