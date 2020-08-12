import 'package:flutter/material.dart';
import 'package:meals_app/utilities/constant.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem({
    Key key,
    this.id,
    this.title,
    this.color,
  }) : super(key: key);

  void _handleOnTapCategory(BuildContext context) {
    // personally I prefer using navigator push instead pushNamed
    // navigator push is much more cleaner I think..

    /*Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoryDetail(
          categoryId: id,
          categoryTitle: title,
        ),
      ),
    );*/

    Navigator.of(context).pushNamed(
      ConstRoutes.CATEGORY_MEALS,
      arguments: {
        ConstRouteArgs.CATEGORY_MEALS_CATEGORY_ID: id,
        ConstRouteArgs.CATEGORY_MEALS_CATEGORY_TITLE: title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleOnTapCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
              ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
