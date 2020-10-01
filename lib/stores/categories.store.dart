import 'package:mobx/mobx.dart';

import '../data/network/repositories/category_repository.dart';
import '../models/Category.dart';

part 'categories.store.g.dart';

class CategoriesStore = _CategoriesStoreBase with _$CategoriesStore;

abstract class _CategoriesStoreBase with Store {
  CategoryRepository repository = new CategoryRepository();

  @observable
  ObservableList<Category> categories = ObservableList<Category>();

  @observable
  List<String> filtersCategory = [];

  @observable
  bool filterChanged = false;

  @observable
  bool isLoading = false;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  void addCategory(Category category) {
    categories.add(category);
  }

  @action
  void removeCategory(Category category) {
    categories.remove(category);
  }

  @action
  void clearCategories() {
    categories.clear();
  }

  @action
  void addFilter(String identify) {
    if (identify == 'all') {
      return clearFilter();
    } else {
      filtersCategory.add(identify);
    }

    categories = categories;
    filterChanged = !filterChanged;
  }

  @action
  void removeFilter(String identify) {
    if (identify != 'all') {
      filtersCategory.remove(identify);
    }

    categories = categories;
    filterChanged = !filterChanged;
  }

  @action
  bool inFilter(String identify) {
    return (identify == 'all' && filtersCategory.length == 0) ||
        filtersCategory.contains(identify);
  }

  @action
  void clearFilter() {
    filtersCategory.clear();

    categories = categories;
    filterChanged = !filterChanged;
  }

  @action
  Future getCategories(String tokenCompany) async {
    setLoading(true);
    clearCategories();
    clearFilter();

    final response = await repository.getCategories(tokenCompany);

    response
        .map((categoryJson) => addCategory(Category.fromJson(categoryJson)))
        .toList();

    setLoading(false);
  }
}
