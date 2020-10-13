import 'dart:convert';

class User {
  String name;
  String email;

  User({this.name, this.email});

  factory User.fromJson(jsonData) {
    return User(
      name: jsonData['name'],
      email: jsonData['email'],
    );
  }

  toJson() {
    return jsonEncode({
      'name': name,
      'email': email,
    });
  }
}
