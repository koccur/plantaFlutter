class Place {
  int id;
  int sunnyLevel;
  String roomName;

  Place({this.id, this.roomName, this.sunnyLevel}) {}

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: json['id'],
        roomName: json['roomName'],
        sunnyLevel: json['sunnyLevel']);
  }

  Map<String,dynamic> toJson()=>{
    "id":id,
    "sunnyLevel":sunnyLevel,
    "roomName":"roomName"
  };
}
