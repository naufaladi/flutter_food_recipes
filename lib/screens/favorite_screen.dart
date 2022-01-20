import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  FavoriteScreen(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return Center(
        child: Text('No favorites has been set'),
      );
    }

    return ListView.builder(
      itemCount: _favoriteMeals.length,
      itemBuilder: (ctx, index) {
        return MealItem(
          id: _favoriteMeals[index].id,
          title: _favoriteMeals[index].title,
          duration: _favoriteMeals[index].duration,
          affordability: _favoriteMeals[index].affordability,
          complexity: _favoriteMeals[index].complexity,
          imageUrl: _favoriteMeals[index].imageUrl,
        );
      },
    );
  }
}
