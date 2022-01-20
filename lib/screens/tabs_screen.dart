import 'package:flutter/material.dart';
import 'package:flutter_food_recipes/widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorite_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages = [];
  int selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // can also be used to display appBar action button dynamiccaly depending on which page/ tab is selected
    // we have to move "pages" value here because we can't use "widget." line above, because there the class hasnt been fully created for some reason
    pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(widget._favoriteMeals),
        'title': 'Favorites',
      }
    ];
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(pages[selectedPageIndex]['title']),
      ),
      body: pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite),
              label: 'Favorites')
        ],
      ),
    );

    // below is an alternative by using DefaultTabController instead which shows the Tabs at the top (below appbar)

    // return DefaultTabController(
    //   length: 2,
    //   initialIndex: 0,
    //   child: Scaffold(
    //       appBar: AppBar(
    //         title: Text('Come up with new Recipeh!'),
    //         bottom: const TabBar(
    //           tabs: <Widget>[
    //             Tab(
    //               icon: Icon(Icons.category),
    //               text: 'Category',
    //             ),
    //             Tab(
    //               icon: Icon(Icons.favorite_border),
    //               text: 'Favorite',
    //             ),
    //           ],
    //         ),
    //       ),
    //       body: TabBarView(children: [
    //         CategoriesScreen(),
    //         FavoriteScreen(),
    //       ])),
    // );
  }
}
