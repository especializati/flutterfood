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
  Future getFoods(String tokenCompany) async {
    setLoading(true);

    final response = await _repository.getFoods(tokenCompany);

    setLoading(false);

    response.map((food) => addFood(Food.fromJson(food))).toList();
  }
}
