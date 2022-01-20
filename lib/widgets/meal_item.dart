import 'package:flutter/material.dart';
import 'package:flutter_food_recipes/screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeMeal;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.removeMeal,
  });

  String get complexityLabel {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break; //break here is redundant because we already tell flutter to return, but im keeping it for learning purpose
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;

      default:
        return 'Unknown';
    }
  }

  String get affordabilityLabel {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break; //break here is redundant because we already tell flutter to return, but im keeping it for learning purpose
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;

      default:
        return 'Bruh What';
    }
  }

  void openMealDetailScreen(BuildContext ctx) {
    Navigator.pushNamed(ctx, MealDetailScreen.mealDetailScreenRoute,
            arguments: id)
        .then((mealId) {
      if (mealId != null) {
        //mealId != null, because if the user taps the back button (instead of remove button), it just returns null as mealId, in which case i dont want to remove this meal item
        removeMeal(mealId);
      }
      // this "mealId" is the mealId that we've passed through pop() function in meal_detail_screen.dart
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openMealDetailScreen(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    width: 280,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 8),
                      Text('${duration} min'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 8),
                      Text('${complexityLabel}'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 2),
                      Text('${affordabilityLabel}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
