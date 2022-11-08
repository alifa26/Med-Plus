class xDataModel {
  xDataModel({
    required this.name,
    required this.image,
  });


  late final String name;
  late final String image;

  xDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorname': name,
      'image': image,
    };
  }
}

