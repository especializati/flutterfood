import 'dart:convert';

class Food {
  String identify;
  String title;
  String description;
  String price;
  String image;

  Food({this.identify, this.title, this.description, this.image, this.price});

  factory Food.fromJson(jsonData) {
    return Food(
      identify: jsonData['identify'],
      title: jsonData['title'],
      description: jsonData['description'],
      price: jsonData['price'],
      image: jsonData['image'],
    );
  }

  toJson() {
    return jsonEncode({
      'identify': identify,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
    });
  }
}
