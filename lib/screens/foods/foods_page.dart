import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../models/Category.dart';
import '../../models/Food.dart';
import '../../models/Restaurant.dart';
import './widgets/Categories.dart';
import '../../widgets/food_card.dart';
import '../../widgets/flutter_bottom_navigator.dart';
import '../../stores/foods.store.dart';
import '../../widgets/custom_circular_progress_indicator.dart';

class FoodsScreen extends StatefulWidget {
  FoodsScreen({Key key}) : super(key: key);

  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  Restaurant _restaurant;
  FoodsStore storeFoods = new FoodsStore();

  List<Category> _categories = [
    Category(name: 'Salgados', description: 'sdd', identify: 'dssfs'),
    Category(name: 'Refri', description: 'sdd', identify: 'dssfs'),
    Category(name: 'Doces', description: 'sdd', identify: 'dssfs'),
    Category(name: 'Pizzas', description: 'sdd', identify: 'dssfs'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    RouteSettings settings = ModalRoute.of(context).settings;
    _restaurant = settings.arguments;

    storeFoods.getFoods(_restaurant.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_restaurant.name}'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildScreen(),
      bottomNavigationBar: FlutterFoodBottomNavigator(0),
    );
  }

  Widget _buildScreen() {
    return Column(
      children: <Widget>[
        Categories(_categories),
        Observer(
          builder: (context) {
            return storeFoods.isLoading
                ? CustomCircularProgressIndicator(
                    textLabel: 'Carregando os produtos...',
                  )
                : storeFoods.foods.length == 0
                    ? Center(
                        child: Text(
                          'Nenhum Produto',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : _buildFoods();
          },
        ),
      ],
    );
  }

  Widget _buildFoods() {
    return Container(
        height: (MediaQuery.of(context).size.height - 190),
        width: MediaQuery.of(context).size.width,
        //color: Colors.black,
        child: ListView.builder(
            itemCount: storeFoods.foods.length,
            itemBuilder: (context, index) {
              final Food food = storeFoods.foods[index];

              return FoodCard(
                identify: food.identify,
                description: food.description,
                image: food.image,
                price: food.price,
                title: food.title,
                notShowIconCart: false,
              );
            }));
  }
}
