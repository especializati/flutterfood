import '../data/network/repositories/food_repository.dart';
import 'package:mobx/mobx.dart';
import '../models/Food.dart';

part 'foods.store.g.dart';

class FoodsStore = _FoodsStoreBase with _$FoodsStore;

abstract class _FoodsStoreBase with Store {
  FoodRepository _repository;

  _FoodsStoreBase() {
    _repository = new FoodRepository();
  }

  @observable
  ObservableList<Food> foods = ObservableList<Food>();

  @observable
  List<Map<String, dynamic>> cartItems = [];

  @observable
  double totalCart = 0;

  @observable
  bool isLoading = false;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  void addFood(Food food) {
    foods.add(food);
  }

  @action
  void addAll(List<Food> foods) {
    foods.addAll(foods);
  }

  @action
  void removeFood(Food food) {
    foods.remove(food);
  }

  @action
  void clearFoods() {
    foods.clear();
  }

  @action
  Future getFoods(String tokenCompany, {List<String> categoriesFilter}) async {
    clearFoods();
    clearCart();

    setLoading(true);

    final response = await _repository.getFoods(tokenCompany,
        filterCategories: categoriesFilter);

    setLoading(false);

    response.map((food) => addFood(Food.fromJson(food))).toList();
  }

  /**
   * Cart
   */
  @action
  void addFoodCart(Food food) {
    print('addFoodCart');

    if (inFoodCart(food)) {
      return incrementFoodCart(food);
    }

    cartItems.add({
      'identify': food.identify,
      'qty': 1,
      'product': food,
    });

    calcTotalCart();
  }

  @action
  void removeFoodCart(Food food) {
    print('removeFoodCart');

    cartItems.removeWhere((element) => element['identify'] == food.identify);

    calcTotalCart();
  }

  @action
  void clearCart() {
    print('clearCart');
    cartItems.clear();

    calcTotalCart();
  }

  @action
  void incrementFoodCart(Food food) {
    print('incrementFoodCart');
    final int index =
        cartItems.indexWhere((element) => element['identify'] == food.identify);

    cartItems[index]['qty'] = cartItems[index]['qty'] + 1;

    calcTotalCart();
  }

  @action
  void decrementFoodCart(Food food) {
    print('decrementFoodCart');
    final int index =
        cartItems.indexWhere((element) => element['identify'] == food.identify);

    cartItems[index]['qty'] = cartItems[index]['qty'] - 1;

    if (cartItems[index]['qty'] == 0) {
      return removeFoodCart(food);
    }

    calcTotalCart();
  }

  @action
  bool inFoodCart(Food food) {
    final int index =
        cartItems.indexWhere((element) => element['identify'] == food.identify);

    return index != -1;
  }

  @action
  double calcTotalCart() {
    print('calcTotalCart');
    double total = 0;

    cartItems
        .map((element) =>
            total += element['qty'] * double.parse(element['product'].price))
        .toList();
    print(total);
    totalCart = total;

    foods = foods;
    cartItems = cartItems;

    return total;
  }
}
