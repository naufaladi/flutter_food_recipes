import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

// commented out due to using routes in main.dart
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  static const categoryMealsScreenRoute = '/category-meals';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData =
      false; //used as a marking, so that didChangeDependencies only runs once

  @override
  void initState() {
    super.initState();
  }

// didChangeDependencies runs after initState, but still run before build runs. (i tried to use initstate but an error shows where apparently ModalRoute can't be used in initState, because context is not yet available)
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadedInitData) {
      super.didChangeDependencies();
      //will run again and overwrites our removeMeal function below, which is why we need the _loadedInitData variable to mark.
      final routeArguments =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      // ModalRoute here is just to get the arguments passed by us in category_item.dart (Getting data in the screen you navigate TO. On other hand, using .pop(data) is useful to retrieve data in the screen you navigated FROM.

      final categoryID = routeArguments['id'];
      categoryTitle = routeArguments['title'];

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryID);
      }).toList();
      _loadedInitData = true;
    }
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            imageUrl: displayedMeals[index].imageUrl,
            removeMeal: removeMeal,
          );
        },
      ),
    );
  }
}
