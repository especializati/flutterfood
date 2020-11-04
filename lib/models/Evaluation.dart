import 'dart:convert';

import './User.dart';

class Evaluation {
  User user;
  String comment;
  double stars;

  Evaluation({this.user, this.comment, this.stars});

  factory Evaluation.fromJson(jsonData) {
    return Evaluation(
      user: User.fromJson(jsonData['client']),
      comment: jsonData['comment'],
      stars: double.parse(jsonData['stars'].toString()),
    );
  }

  toJson() {
    return jsonEncode({
      'user': user,
      'comment': comment,
      'stars': stars,
    });
  }
}
