import 'package:flutter/material.dart';
import 'package:meals_app/utilities/constant.dart';
import 'package:meals_app/utilities/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = ConstRoutes.MEAL_DETAIL;
  final Function toggleFavorite;
  final Function isFavoriteMeal;

  MealDetailScreen({
    @required this.toggleFavorite,
    @required this.isFavoriteMeal,
  });

  Widget _buildTitle(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildListWrapper(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      width: 300,
      height: 150,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((m) => m.id == mealId);
    final isFavorite = isFavoriteMeal(mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          // for wrapping content vertically, because by default -
          // column widget height is as far as screen height
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildTitle('Ingredients', context),
            _buildListWrapper(
              ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, i) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      meal.ingredients[i],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            _buildTitle('Steps', context),
            _buildListWrapper(
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: meal.steps.length,
                itemBuilder: (ctx, i) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '#${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      title: Text(meal.steps[i]),
                    ),
                    if (i != meal.steps.length - 1) Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          isFavorite ? Icons.star : Icons.star_border,
          color: isFavorite ? Colors.amber : Colors.white.withOpacity(0.5),
        ),
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
