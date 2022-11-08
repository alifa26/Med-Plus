class DoctorDataModel {
  DoctorDataModel({
    required this.dId,
    required this.doctorname,
    required this.email,
    required this.specialization,
    required this.image,
    required this.key,
  });

  late final String dId;
  late final String doctorname;
  late final String email;
  late final String specialization;
  late final String image;
  late final String key;

  DoctorDataModel.fromJson(Map<String, dynamic> json) {
    dId = json['dId'] ?? '';
    doctorname = json['doctorname'] ?? '';
    email = json['email'] ?? '';
    specialization = json['specialization'] ?? '';
    image = json['image'] ?? '';
    key = json['key'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'dId': dId,
      'doctorname': doctorname,
      'email': email,
      'specialization': specialization,
      'image': image,
      'key': key,
    };
  }
}

