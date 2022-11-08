class percModel {
  percModel({
    required this.lat,
    required this.name,
    required this.email,
    required this.number,
    required this.image,
    required this.lon,
    
  });

  late final String lat;
  late final String name;
  late final String email;
  late final String number;
  late final String image;
  late final String lon;

  percModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    number = json['number'] ?? '';
    image = json['image'] ?? '';
    lon = json['lon'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'name': name,
      'email': email,
      'number': number,
      'image': image,
      'lon': lon,
    };
  }
}

