import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  String identify;
  String title;
  String description;
  String price;
  String image;
  bool notShowIconCart;

  FoodCard({
    this.identify,
    this.title,
    this.description,
    this.image,
    this.price,
    this.notShowIconCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.5,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[100]),
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                _buildImageFood(),
                _buildInfoFood(),
                _buildButtonCart(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageFood() {
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.only(right: 8),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl:
              image != '' ? image : 'http://10.0.2.2/imgs/IconeFlutterFood.png',
          placeholder: (context, url) => Container(
            height: 80,
            width: 80,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoFood() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          Container(height: 5),
          Text(description,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              )),
          Container(height: 7),
          Text("R\$ $price",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }

  Widget _buildButtonCart(context) {
    return notShowIconCart
        ? Container()
        : Container(
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: Icon(Icons.shopping_cart),
            ),
          );
  }
}
