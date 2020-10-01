import 'package:mobx/mobx.dart';

import '../models/Restaurant.dart';

part 'restaurant.store.g.dart';

class RestaurantsStore = _RestaurantsStoreBase with _$RestaurantsStore;

abstract class _RestaurantsStoreBase with Store {
  @observable
  Restaurant restaurant = null;

  @action
  void setRestaurant(Restaurant value) => restaurant = value;
}
