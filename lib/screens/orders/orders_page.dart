import 'package:flutter/material.dart';

import '../../widgets/flutter_bottom_navigator.dart';
import '../../models/Order.dart';

class OrdersScreen extends StatelessWidget {
  List<Order> _orders = [
    new Order(date: '30/02/2021', identify: '0ksjdj132u'),
    new Order(date: '30/03/2021', identify: '1ksjdj132u'),
    new Order(date: '30/04/2021', identify: '2ksjdj132u'),
    new Order(date: '30/05/2021', identify: '3ksjdj132u'),
    new Order(date: '30/06/2021', identify: '4ksjdj132u'),
    new Order(date: '30/07/2021', identify: '5ksjdj132u'),
    new Order(date: '30/08/2021', identify: '6ksjdj132u'),
    new Order(date: '30/09/2021', identify: '7ksjdj132u'),
    new Order(date: '30/10/2021', identify: '8ksjdj132u'),
    new Order(date: '30/11/2021', identify: '9ksjdj132u'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos'), centerTitle: true),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildOrderScreen(context),
      bottomNavigationBar: FlutterFoodBottomNavigator(1),
    );
  }

  Widget _buildOrderScreen(context) {
    return Column(
      children: <Widget>[
        _buildHeader(),
        _buildOrdersList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Text(
        'Meus Pedidos',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildOrdersList() {
    return Expanded(
      child: ListView.builder(
        //shrinkWrap: true,
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final Order order = _orders[index];
          return _buildItemOrder(order, context);
        },
      ),
    );
  }

  Widget _buildItemOrder(Order order, context) {
    return ListTile(
      title: Text(
        "Pedido #${order.identify}",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      subtitle: Text(
        "${order.date}",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      trailing: IconTheme(
        data: IconThemeData(color: Theme.of(context).primaryColor),
        child: Icon(Icons.navigate_next),
      ),
      onTap: () {
        print(order.identify);
      },
    );
  }
}
