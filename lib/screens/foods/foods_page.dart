import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../models/Food.dart';
import '../../models/Restaurant.dart';
import './widgets/Categories.dart';
import '../../widgets/food_card.dart';
import '../../widgets/flutter_bottom_navigator.dart';
import '../../stores/foods.store.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../stores/categories.store.dart';
import '../../stores/restaurant.store.dart';

class FoodsScreen extends StatefulWidget {
  FoodsScreen({Key key}) : super(key: key);

  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  Restaurant _restaurant;
  //FoodsStore storeFoods = new FoodsStore();
  FoodsStore storeFoods;
  CategoriesStore storeCategories;
  RestaurantsStore restaurantsStore;
  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    storeFoods = Provider.of<FoodsStore>(context);
    storeCategories = Provider.of<CategoriesStore>(context);
    restaurantsStore = Provider.of<RestaurantsStore>(context);

    RouteSettings settings = ModalRoute.of(context).settings;
    _restaurant = settings.arguments;

    disposer =
        reaction((_) => storeCategories.filterChanged, (filterChanged) async {
      if (!storeCategories.isLoading && !storeFoods.isLoading) {
        await storeFoods.getFoods(_restaurant.uuid,
            categoriesFilter: storeCategories.filtersCategory);
      }
    });

    restaurantsStore.setRestaurant(_restaurant);
    storeCategories.getCategories(_restaurant.uuid);
    storeFoods.getFoods(_restaurant.uuid);
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
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
        Observer(
          builder: (context) {
            return storeCategories.isLoading
                ? CustomCircularProgressIndicator(
                    textLabel: 'Carregando as categorias...',
                  )
                : storeCategories.categories.length == 0
                    ? Center(
                        child: Text(
                          'Nenhuma Categoria',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : Categories(storeCategories.categories);
          },
        ),
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

              return FoodCard(food: food);
            }));
  }
}
