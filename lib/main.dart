import 'package:flutter/material.dart';
import 'package:flutter_food_recipes/dummy_data.dart';
import 'package:flutter_food_recipes/screens/filters_screen.dart';
import 'package:flutter_food_recipes/screens/meal_detail_screen.dart';
import 'package:flutter_food_recipes/screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _filteredMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  void _toggleFavorite(String mealId) {
    final int existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _filteredMeals = DUMMY_MEALS.where((meal) {
        // if (_filters['gluten'] == true) is actually the same as if (_filters['gluten']), but im still adding the == true just as documentation
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipeh',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber[300],
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.black87),
              bodyText2: TextStyle(color: Colors.black87),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMealsScreen.categoryMealsScreenRoute: (ctx) =>
            CategoryMealsScreen(_filteredMeals),
        MealDetailScreen.mealDetailScreenRoute: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.FiltersScreenRoute: (ctx) =>
            FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute (settings): ,                          // not used here, but useful to know for the future. This basically return a spesific screen/route if we tried to pushNamed() a route which have not been defined on routes: in main.dart
      //    print(settings.arguments);
      //    if (settings.name == '/meal-detail') {
      //      return ...                                        // can be used to set a condition, and if true return a spesific screen for example
      //}   else if (settings.name == '/something-else') {
      //      return ...
      //    }
      //
      //    return MaterialPageRoute(builder: (ctx) => CategoriesScreen())
      //
      onUnknownRoute: (settings) {
        // onUnknownRoute is reached only when flutter fails to route a screen with all other measures. To avoid crash/error and instead display something (for example can be a 404 not found page)
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
