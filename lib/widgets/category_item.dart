import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void openCategoryMealsScreen(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(CategoryMealsScreen.categoryMealsScreenRoute, arguments: {
      'id': id,
      'title': title,
    });

    // above is a pushNamed() using route method. Alternatively we can use
    // push() to push screens which have not been defined in advance like this:
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return CategoryMealsScreen(id, title);
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openCategoryMealsScreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
