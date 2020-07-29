import 'package:flutter/material.dart';

import '../../models/Category.dart';
import '../../models/Food.dart';
import './widgets/Categories.dart';
import '../../widgets/food_card.dart';
import '../../widgets/flutter_bottom_navigator.dart';

class FoodsScreen extends StatefulWidget {
  FoodsScreen({Key key}) : super(key: key);

  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  List<Category> _categories = [
    Category(name: 'Salgados', description: 'sdd', identify: 'dssfs'),
    Category(name: 'Refri', description: 'sdd', identify: 'dssfs'),
    Category(name: 'Doces', description: 'sdd', identify: 'dssfs'),
    Category(name: 'Pizzas', description: 'sdd', identify: 'dssfs'),
  ];
  List<Food> _foods = [
    Food(
        identify: 'asds',
        image:
            'http://10.0.2.2/storage/tenants/3e73e976-6ce1-44c4-8f11-1ca4b434ea4a/products/6ZyL7DMASrQAfvggPRfc6WxEFJVbT4hmQIVMnYCe.png',
        description: 'Apenas um teste',
        price: '12.2',
        title: 'Comida Japonesa'),
    Food(
        identify: 'asds3',
        image:
            'http://10.0.2.2/storage/tenants/3e73e976-6ce1-44c4-8f11-1ca4b434ea4a/products/w0XphjnLbQJOSdRycJsYQIVDqHnET5RX2YFsdq6K.png',
        description: 'Apenas um teste',
        price: '14.2',
        title: 'Sanduíche'),
    Food(
        identify: 'asds2',
        image:
            'http://10.0.2.2/storage/tenants/3e73e976-6ce1-44c4-8f11-1ca4b434ea4a/products/EIb2oEnQgAabrk2OkXeb6BAAGW680H8CPzpdJBgG.png',
        description: 'Apenas um teste',
        price: '15.2',
        title: 'Açaí'),
    Food(
        identify: 'asds43',
        image:
            'http://10.0.2.2/storage/tenants/3e73e976-6ce1-44c4-8f11-1ca4b434ea4a/products/4mnaq2bMcOBA0JrdxDwZhxMibpy1M1DrMpSejwMG.png',
        description: 'Apenas um teste',
        price: '16.2',
        title: 'Pizza')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EspecializaTi Res'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildScreen(),
      bottomNavigationBar: FlutterFoodBottomNavigator(0),
    );
  }

  Widget _buildScreen() {
    return Column(
      children: <Widget>[Categories(_categories), _buildFoods()],
    );
  }

  Widget _buildFoods() {
    return Container(
      height: (MediaQuery.of(context).size.height - 190),
      width: MediaQuery.of(context).size.width,
      //color: Colors.black,
      child: ListView.builder(
          itemCount: _foods.length,
          itemBuilder: (context, index) {
            final Food food = _foods[index];

            return FoodCard(
              identify: food.identify,
              description: food.description,
              image: food.image,
              price: food.price,
              title: food.title,
              notShowIconCart: false,
            );
          }),
    );
  }
}
