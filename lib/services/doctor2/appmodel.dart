class AppModel {
  AppModel
({
    required this.username,
    required this.uId,
    required this.day,
    required this.image,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
    required this.email,
    required this.lat,
    required this.lon,
    required this.number
  });

  late final String uId;
  late final String username;
  late final String day;
  late final String image;
  late final String month;
  late final String year;
  late final String hour;
  late final String email;
  late final String minute;
  late final String lat;
  late final String lon;
  late final String number;
  


  AppModel
.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    day = json['day'] ?? '';
    image = json['image'] ?? '';
    month = json['month'] ?? '';
    year = json['year'] ?? '';
    hour = json['hour'] ?? '';
    minute = json['minute'] ?? '';
    email = json['email'] ?? '';
    lat = json['lat'] ?? '';
    lon = json['lon'] ?? '';
    number = json['number'] ?? '';

  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'day': day,
      'image': image,
      'month': month,
      'year': year,
      'hour':hour,
      'minute':minute,
      'email':email,
      'lat' :lat,
      'lon' : lon,
      'number' : number
      
    };
  }
}

