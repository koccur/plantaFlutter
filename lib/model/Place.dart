class Place {
  final int id;
  final int sunnyLevel;
  final String roomName;

  Place({this.id, this.roomName, this.sunnyLevel}) {}

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: json['id'],
        roomName: json['roomName'],
        sunnyLevel: json['sunnyLevel']);
  }
}
