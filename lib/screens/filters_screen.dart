import 'package:flutter/material.dart';
import 'package:meals_app/models/filter.dart';
import 'package:meals_app/utilities/constant.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = ConstRoutes.FILTERS;
  final Function saveFilter;
  final Filter filter;

  FiltersScreen({
    @required this.saveFilter,
    @required this.filter,
  });

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  @override
  void initState() {
    super.initState();

    _glutenFree = widget.filter.isGlutenFree;
    _vegetarian = widget.filter.isVegetarian;
    _lactoseFree = widget.filter.isLactoseFree;
    _vegan = widget.filter.isVegan;
  }

  void _saveGlobalFilter() {
    var filter = Filter(
      isVegetarian: _vegetarian,
      isVegan: _vegan,
      isLactoseFree: _lactoseFree,
      isGlutenFree: _glutenFree,
    );

    widget.saveFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveGlobalFilter,
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Gluten-free'),
                  value: _glutenFree,
                  onChanged: (val) => setState(() => _glutenFree = val),
                ),
                SwitchListTile(
                  title: Text('Vegetarian'),
                  value: _vegetarian,
                  onChanged: (val) => setState(() => _vegetarian = val),
                ),
                SwitchListTile(
                  title: Text('Vegan'),
                  value: _vegan,
                  onChanged: (val) => setState(() => _vegan = val),
                ),
                SwitchListTile(
                  title: Text('lactose-free'),
                  value: _lactoseFree,
                  onChanged: (val) => setState(() => _lactoseFree = val),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
