import 'dart:convert';

class Evaluation {
  String nameUser;
  String comment;
  double stars;

  Evaluation({this.nameUser, this.comment, this.stars});

  factory Evaluation.fromJson(jsonData) {
    return Evaluation(
      nameUser: jsonData['nameUser'],
      comment: jsonData['comment'],
      stars: jsonData['stars'],
    );
  }

  toJson() {
    return jsonEncode({
      'nameUser': nameUser,
      'comment': comment,
      'stars': stars,
    });
  }
}
