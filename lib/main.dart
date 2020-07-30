import 'package:flutter/material.dart';

import './screens/auth/login_page.dart';
import './screens/auth/register_page.dart';
import './screens/restaurants/restaurants_page.dart';
import './screens/foods/foods_page.dart';
import './screens/carts/cart_page.dart';
import './screens/orders/orders_page.dart';
import './screens/order_details/order_details.dart';
import './screens/evaluation_order/evaluation_order.dart';

void main() => runApp(FlutterFoodApp());

class FlutterFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterFood',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(147, 70, 248, 1),
          backgroundColor: Colors.white,
          accentColor: Colors.black,
          brightness: Brightness.dark),
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/restaurants': (context) => RestaurantsPage(),
        '/foods': (context) => FoodsScreen(),
        '/cart': (context) => CartScreen(),
        '/my-orders': (context) => OrdersScreen(),
        '/order-details': (context) => OrderDetailsScreen(),
        '/evaluation-order': (context) => EvaluationOrderScreen(),
      },
    );
  }
}
