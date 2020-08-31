import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/network/repositories/restaurant_repository.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../models/Restaurant.dart';
import './widgets/RestaurantCard.dart';
import '../../widgets/flutter_bottom_navigator.dart';

class RestaurantsPage extends StatefulWidget {
  RestaurantsPage({Key key}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  List<Restaurant> _restaurants = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: isLoading
          ? CustomCircularProgressIndicator(
              textLabel: 'Carregando os restaurantes',
            )
          : _buildRestaurants(context),
      bottomNavigationBar: FlutterFoodBottomNavigator(0),
    );
  }

  Widget _buildRestaurants(context) {
    return Container(
      child: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          final Restaurant restaurant = _restaurants[index];

          return RestaurantCard(restaurant: restaurant);
        },
      ),
    );
  }

  void getRestaurants() async {
    setState(() => isLoading = true);

    final restaurants = await ResturantRepository().getRestaurants();

    setState(() {
      _restaurants.addAll(restaurants);
    });

    setState(() => isLoading = false);
  }
}
