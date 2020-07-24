import 'dart:convert';

class Category {
  String identify;
  String name;
  String description;

  Category({this.identify, this.name, this.description});

  factory Category.fromJson(jsonData) {
    return Category(
      identify: jsonData['identify'],
      name: jsonData['name'],
      description: jsonData['description'],
    );
  }

  toJson() {
    return jsonEncode({
      'identify': identify,
      'name': name,
      'description': description,
    });
  }
}
