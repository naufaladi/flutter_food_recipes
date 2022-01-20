import 'package:flutter/material.dart';
import 'package:flutter_food_recipes/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const FiltersScreenRoute = '/filters';

  final Map<String, bool> currentFilters;
  final Function applyFilters;

  FiltersScreen(this.currentFilters, this.applyFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenFree = false;
  bool isVegetarian = false;
  bool isVegan = false;
  bool isLactoseFree = false;

  @override
  void initState() {
    super.initState();
    isGlutenFree = widget.currentFilters['gluten'];
    isVegetarian = widget.currentFilters['vegetarian'];
    isLactoseFree = widget.currentFilters['lactose'];
    isVegan = widget.currentFilters['vegan'];
  }

  Widget buildSwitchTile(
    String title,
    String subTitle,
    bool switchValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subTitle),
      value: switchValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': isGlutenFree,
                'lactose': isLactoseFree,
                'vegetarian': isVegetarian,
                'vegan': isVegan,
              };
              widget.applyFilters(selectedFilters);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
            padding: EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTile(
                  'Gluten-Free',
                  'Only include gluten free meals',
                  isGlutenFree,
                  (newValue) {
                    setState(() {
                      isGlutenFree = newValue;
                    });
                  },
                ),
                buildSwitchTile(
                  'Lactose-Free',
                  'Only include lactose free meals',
                  isLactoseFree,
                  (newValue) {
                    setState(() {
                      isLactoseFree = newValue;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  isVegetarian,
                  (newValue) {
                    setState(() {
                      isVegetarian = newValue;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegan',
                  'Only include vegan meals',
                  isVegan,
                  (newValue) {
                    setState(() {
                      isVegan = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
