class NotficModel {
  NotficModel({
    required this.uId,
    required this.username,
    required this.text,
    required this.type,
    required this.image,
    required this.date,
    required this.lat,
    required this.lon,
    required this.number
  });

  late final String uId;
  late final String username;
  late final String text;
  late final String type;
  late final String image;
  late final String date;
  late final String lat;
  late final String lon;
  late final String number;
  


  NotficModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    text = json['text'] ?? '';
    type = json['type'] ?? '';
    image = json['image'] ?? '';
    date = json['date'] ?? '';
    lat = json['lat'] ?? '';
    lon = json['lon'] ?? '';
    number = json['number'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'text': text,
      'type': type,
      'image': image,
      'date':date,
       'lat' :lat,
       'lon' : lon,
       'number' : number
      
    };
  }
}

