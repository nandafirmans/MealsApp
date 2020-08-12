import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/utilities/constant.dart';
import 'package:meals_app/widgets/category_list.dart';
import 'package:meals_app/widgets/favorite_list.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = ConstRoutes.TABS;
  final List<Meal> favoritesMeal;

  TabsScreen({
    @required this.favoritesMeal,
  });

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _screens;
  int _selectedScreenIndex = 0;

  @override
  void initState() {
    super.initState();

    _screens = [
      {
        'screen': CategoryList(),
        'title': 'Categories',
      },
      {
        'screen': FavoriteList(
          favoritesMeal: widget.favoritesMeal,
        ),
        'title': 'Your Favorites',
      },
    ];
  }

  void _onBottomNavigationTap(int value) {
    setState(() {
      _selectedScreenIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _onBottomNavigationTap,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          )
        ],
      ),
    );
  }
}
