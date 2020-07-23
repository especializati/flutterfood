import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String uuid;
  final String name;
  final String image;
  final String contact;

  RestaurantCard({this.uuid, this.name, this.image, this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, right: 1, left: 1),
      child: Card(
        elevation: 2.5,
        child: Container(
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    child: ClipOval(
                      child: Image.asset('assets/images/IconeFlutterFood.png'),
                    ),
                  ),
                  VerticalDivider(color: Colors.black54),
                  Expanded(
                      child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            )),
      ),
    );
  }
}
