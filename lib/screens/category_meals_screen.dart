import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/utilities/constant.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = ConstRoutes.CATEGORY_MEALS;
  final List<Meal> availableMeals;

  CategoryMealsScreen({
    @required this.availableMeals,
  });

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  String categoryId;
  List<Meal> displayedMeals;
  var _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      Map<String, String> routeArgs = ModalRoute.of(context).settings.arguments;
      categoryId = routeArgs[ConstRouteArgs.CATEGORY_MEALS_CATEGORY_ID];
      categoryTitle = routeArgs[ConstRouteArgs.CATEGORY_MEALS_CATEGORY_TITLE];
      displayedMeals = widget.availableMeals
          .where((m) => m.categoriesId.contains(categoryId))
          .toList();
      _isDataLoaded = false;
    }
  }

  void _removeMeal(String mealId) {
    if (mealId != null) {
      setState(() {
        displayedMeals.removeWhere((m) => m.id == mealId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? ""),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: displayedMeals != null ? displayedMeals.length : 0,
        itemBuilder: (ctx, i) => MealItem(
          key: ValueKey(displayedMeals[i].id),
          id: displayedMeals[i].id,
          title: displayedMeals[i].title,
          affordability: displayedMeals[i].affordability,
          complexity: displayedMeals[i].complexity,
          duration: displayedMeals[i].duration,
          imageUrl: displayedMeals[i].imageUrl,
          removeMeal: _removeMeal,
        ),
      ),
    );
  }
}
