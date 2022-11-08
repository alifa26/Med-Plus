class PharmacyModel {
  PharmacyModel({
    required this.number,
    required this.name,
    required this.email,
    required this.image,
    
  });

  late final String number;
  late final String name;
  late final String email;
  late final String image;

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    number = json['number'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'email': email,
      'image': image,
    };
  }
}

