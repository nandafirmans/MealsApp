import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_enums.dart';
import 'package:meals_app/utilities/constant.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final MealComplexity complexity;
  final MealAffordability affordability;
  final Function removeMeal;

  MealItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.removeMeal,
  }) : super(key: key);

  String get complexityText {
    switch (complexity) {
      case MealComplexity.Challenging:
        return "Challenging";
      case MealComplexity.Simple:
        return "Simple";
      case MealComplexity.Hard:
        return "Hard";
    }

    return "Unknown";
  }

  String get affordabilityText {
    switch (affordability) {
      case MealAffordability.Affordable:
        return "Affordable";
      case MealAffordability.Pricey:
        return "Pricey";
      case MealAffordability.Luxurious:
        return "Luxurious";
    }

    return "Unknown";
  }

  _handleOnMealTap(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          ConstRoutes.MEAL_DETAIL,
          arguments: id,
        )
        .then((result) => result != null && removeMeal(result));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => _handleOnMealTap(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          margin: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 18,
                        left: 15,
                        right: 15,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.black38,
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
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
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer),
                        SizedBox(width: 5),
                        Text('$duration min'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work),
                        SizedBox(width: 5),
                        Text(complexityText),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(width: 5),
                        Text(affordabilityText),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
