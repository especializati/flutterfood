import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './contants/app_theme.dart';
import './routes.dart';
import './stores/foods.store.dart';
import './stores/categories.store.dart';

void main() => runApp(FlutterFoodApp());

class FlutterFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FoodsStore>(
          create: (_) => FoodsStore(),
        ),
        Provider<CategoriesStore>(
          create: (_) => CategoriesStore(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterFood',
        theme: themeData,
        initialRoute: '/',
        routes: Routes.routes,
      ),
    );
  }
}
