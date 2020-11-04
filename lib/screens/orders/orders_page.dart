import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterfood/widgets/custom_circular_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../../widgets/flutter_bottom_navigator.dart';
import '../../models/Order.dart';
import '../../stores/orders.store.dart';

class OrdersScreen extends StatelessWidget {
  OrdersStore _ordersStore;

  @override
  Widget build(BuildContext context) {
    _ordersStore = Provider.of<OrdersStore>(context);
    _ordersStore.getMyOrders();

    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos'), centerTitle: true),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Observer(
        builder: (context) => _buildOrderScreen(context),
      ),
      bottomNavigationBar: FlutterFoodBottomNavigator(1),
    );
  }

  Widget _buildOrderScreen(context) {
    return Column(
      children: <Widget>[
        _buildHeader(),
        _ordersStore.isLoading
            ? CustomCircularProgressIndicator(
                textLabel: 'Carregando os pedidos')
            : _buildOrdersList(),
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
        itemCount: _ordersStore.orders.length,
        itemBuilder: (context, index) {
          final Order order = _ordersStore.orders[index];
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
        Navigator.pushNamed(
          context,
          '/order-details',
          arguments: order,
        );
      },
    );
  }
}
