import 'package:flutter/material.dart';
import 'package:meals_app/utilities/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(15),
      children: DUMMY_CATEGORIES
          .map(
            (c) => CategoryItem(
              key: ValueKey(c.id),
              id: c.id,
              title: c.title,
              color: c.color,
            ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    );
  }
}
