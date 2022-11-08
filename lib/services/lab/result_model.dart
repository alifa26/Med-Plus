class ResultModel {
  ResultModel({
    required this.uId,
    required this.username,
    required this.text,
    required this.pdf,
    required this.image,
    required this.date,
    required this.number
  });

  late final String uId;
  late final String username;
  late final String text;
  late final String pdf;
  late final String image;
  late final String date;
  late final String number;
  


  ResultModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    text = json['text'] ?? '';
    pdf = json['pdf'] ?? '';
    image = json['image'] ?? '';
    date = json['date'] ?? '';
    number = json['number'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'text': text,
      'pdf': pdf,
      'image': image,
      'date':date,
       'number' : number
      
    };
  }
}

