class DoctorsDataModel {
  DoctorsDataModel({
    required this.dId,
    required this.doctorname,
    required this.email,
    required this.specialization,
    required this.image,
    required this.key,
    required this.converted,
    
  });

  late final String dId;
  late final String doctorname;
  late final String email;
  late final String specialization;
  late final String image;
  late final String key;
  late final List<String> converted;  

  DoctorsDataModel.fromJson(Map<String, dynamic> json) {
    dId = json['dId'] ?? '';
    doctorname = json['doctorname'] ?? '';
    email = json['email'] ?? '';
    specialization = json['specialization'] ?? '';
    image = json['image'] ?? '';
    key = json['key'] ?? '';
    converted = List.from(json['converted']).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'dId': dId,
      'doctorname': doctorname,
      'email': email,
      'specialization': specialization,
      'image': image,
      'key': key,
      'converted': converted.map((element) => element).toList(),
    };
  }
}

