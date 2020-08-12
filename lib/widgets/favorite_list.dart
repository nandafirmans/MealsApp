import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoriteList extends StatelessWidget {
  final List<Meal> favoritesMeal;

  FavoriteList({
    @required this.favoritesMeal,
  });

  @override
  Widget build(BuildContext context) {
    if (favoritesMeal.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: favoritesMeal != null ? favoritesMeal.length : 0,
      itemBuilder: (ctx, i) => MealItem(
        key: ValueKey(favoritesMeal[i].id),
        id: favoritesMeal[i].id,
        title: favoritesMeal[i].title,
        affordability: favoritesMeal[i].affordability,
        complexity: favoritesMeal[i].complexity,
        duration: favoritesMeal[i].duration,
        imageUrl: favoritesMeal[i].imageUrl,
        removeMeal: () {},
      ),
    );
  }
}
