import 'package:flutter/material.dart';
import '../widgets/category_item.dart';

import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(22),
      children: DUMMY_CATEGORIES.map((category) {
        return CategoryItem(category.id, category.title, category.color);
      }).toList(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // determines the width of each grid item
        childAspectRatio: 3 / 2, // 3(height) / 2(width)
        crossAxisSpacing: 19,
        mainAxisSpacing: 19,
      ),
    );
  }
}
