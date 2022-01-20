import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const mealDetailScreenRoute = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildListContainer(double width, Widget child) {
    return Container(
      height: 180,
      width: width,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            // below is alternative child using .map instead of ListView.builder
            // ListView(
            //   children: selectedMeal.ingredients
            //       .map((ingredient) => Text(ingredient))
            //       .toList()),
            buildListContainer(
              300,
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildListContainer(
              350,
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text((index + 1).toString()),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          style: TextStyle(fontSize: 14),
                        ),

                        // color: Theme.of(context).accentColor,
                        // child: Padding(
                        //   padding:
                        //       const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        //   child: Text(selectedMeal.steps[index]),
                        // ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(selectedMeal.id)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
        onPressed: () {
          toggleFavorite(selectedMeal.id);
        },

        // below is just a demo of using pop() to pop this meal detail screen when user pressed the floating button
        // child: Icon(Icons.delete_outlined),
        // onPressed: () {
        //   Navigator.pop(context, mealId);
        //   //mealId in .pop() is the data we're trying to pass so that it can be retrieved with the .then method in the pushNamed() in meal_item.dart (that is, the screen we navigated FROM)
        // },
      ),
    );
  }
}
