import 'dart:convert';

class Restaurant {
  String uuid;
  String name;
  String image;
  String contact;

  Restaurant({this.uuid, this.name, this.image, this.contact});

  factory Restaurant.fromJson(jsonData) {
    return Restaurant(
      uuid: jsonData['uuid'],
      name: jsonData['name'],
      image: jsonData['image'],
      contact: jsonData['contact'],
    );
  }

  toJson() {
    return jsonEncode({
      'uuid': uuid,
      'name': name,
      'image': image,
      'contact': contact,
    });
  }
}
