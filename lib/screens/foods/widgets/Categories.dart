import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../stores/categories.store.dart';

import '../../../models/Category.dart';

class Categories extends StatelessWidget {
  List<Category> _categories;
  CategoriesStore categoriesStore;

  Categories(this._categories);

  @override
  Widget build(BuildContext context) {
    categoriesStore = Provider.of<CategoriesStore>(context);
    return _buildCategories();
  }

  Widget _buildCategories() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final Category category =
                Category.fromJson({'identify': 'all', 'name': 'Todas'});
            return _buildCategory(category);
          }

          final Category category = _categories[index - 1];
          return _buildCategory(category);
        },
      ),
    );
  }

  Widget _buildCategory(Category category) {
    final String identifyCategory = category.identify;
    final bool inFilter = categoriesStore.inFilter(identifyCategory);
    return GestureDetector(
      onTap: () => inFilter
          ? categoriesStore.removeFilter(category.identify)
          : categoriesStore.addFilter(category.identify),
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 20, right: 20),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: inFilter ? Colors.black : Colors.grey)),
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(
                color: inFilter ? Colors.black : Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
