import 'package:flutter/material.dart';
import 'package:meals_app/models/filter.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:meals_app/screens/unknown_screen.dart';
import 'package:meals_app/utilities/dummy_data.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _filter = Filter(
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
  );
  var _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeal = [];

  void _toggleFavoritesMeal(String mealId) {
    if (mealId != null && mealId.isNotEmpty) {
      final existingIndex = _favoritesMeal.indexWhere((m) => m.id == mealId);

      if (existingIndex >= 0) {
        setState(() {
          _favoritesMeal.removeAt(existingIndex);
        });
      } else {
        setState(() {
          _favoritesMeal.add(DUMMY_MEALS.firstWhere((m) => m.id == mealId));
        });
      }
    }
  }

  bool _isFavoriteMeal(String mealId) {
    return _favoritesMeal.any((m) => m.id == mealId);
  }

  void _setFilter(Filter filter) {
    if (filter != null) {
      setState(() {
        _filter = filter;
        _availableMeals = DUMMY_MEALS.where((m) {
          if (filter.isGlutenFree && !m.isGlutenFree) {
            return false;
          }
          if (filter.isLactoseFree && !m.isLactoseFree) {
            return false;
          }
          if (filter.isVegan && !m.isVegan) {
            return false;
          }
          if (filter.isVegetarian && !m.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      /*
        * registering named route on routes table.
        * navigating between routes is using navigation.pushNamed method.
        * passing data between routes using arguments.
      */
      initialRoute: TabsScreen.routeName,
      routes: {
        TabsScreen.routeName: (_) => TabsScreen(
              favoritesMeal: _favoritesMeal,
            ),
        CategoryMealsScreen.routeName: (_) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (_) => MealDetailScreen(
              toggleFavorite: _toggleFavoritesMeal,
              isFavoriteMeal: _isFavoriteMeal,
            ),
        FiltersScreen.routeName: (_) => FiltersScreen(
              saveFilter: _setFilter,
              filter: _filter,
            ),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => UnknownScreen(),
      ),
    );
  }
}
