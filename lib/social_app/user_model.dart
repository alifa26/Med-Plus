class UserDataModel {
  UserDataModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.token,
    required this.image,
    required this.num,
    required this.blood,
    required this.lon,
    required this.lat,
    required this.tag,
  });

  late final String uId;
  late final String username;
  late final String email;
  late final String token;
  late final String image;
  late final String num;
  late final String blood;
  late final String lon;
  late final String lat;
  late final String tag;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    token = json['token'] ?? '';
    image = json['image'] ?? '';
    num = json['num'] ?? '';
    blood = json['blood'] ?? '';
    lon = json['lon'] ?? '';
    lat = json['lat'] ?? '';
    tag = json['tag'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'token': token,
      'image': image,
      'image': image,
      'num': num,
      'blood': blood,
      'lon': lon,
      'lat': lat,
      'tag': tag,
    };
  }
}

