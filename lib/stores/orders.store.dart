import 'package:mobx/mobx.dart';

import '../data/network/repositories/order_repository.dart';
import '../models/Order.dart';

part 'orders.store.g.dart';

class OrdersStore = _OrdersStoreBase with _$OrdersStore;

abstract class _OrdersStoreBase with Store {
  OrderRepository _orderRepository = OrderRepository();

  @observable
  bool isMakingOrder = false;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Order> orders = ObservableList<Order>();

  @action
  Future makeOrder(String tokenCompany, List<Map<String, dynamic>> foods,
      {String comment}) async {
    isMakingOrder = true;

    await _orderRepository.makeOrder(tokenCompany, foods, comment: comment);

    isMakingOrder = false;
  }

  @action
  void add(Order order) {
    orders.add(order);
  }

  @action
  void clear() {
    orders.clear();
  }

  @action
  Future getMyOrders() async {
    clear();
    isLoading = true;

    final response = await _orderRepository.getMyOrders();

    response.map((order) => add(Order.fromJson(order))).toList();

    isLoading = false;
  }
}
