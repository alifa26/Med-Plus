class PcrModel {
  PcrModel({
    required this.uId,
    required this.username,
    required this.text,
    required this.passport,
    required this.image,
    required this.date,
    required this.number,
    required this.email,
  });

  late final String uId;
  late final String username;
  late final String text;
  late final String passport;
  late final String image;
  late final String date;
  late final String number;
  late final String email;
  


  PcrModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    text = json['text'] ?? '';
    passport = json['passport'] ?? '';
    image = json['image'] ?? '';
    date = json['date'] ?? '';
    number = json['number'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'text': text,
      'passport': passport,
      'image': image,
      'date':date,
       'number' : number,
       'email' : email
      
    };
  }
}

