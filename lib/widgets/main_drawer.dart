import 'package:flutter/material.dart';
import 'package:flutter_food_recipes/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildDrawerListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).accentColor,
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(19),
            alignment:
                Alignment.centerLeft, //vertically center, horizontally left
            child: const Text(
              'Cooking up',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildDrawerListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          buildDrawerListTile(
            'Filters',
            Icons.settings,
            () {
              Navigator.pushReplacementNamed(
                  context, FiltersScreen.FiltersScreenRoute);
            },
          ),
        ],
      ),
    );
  }
}
