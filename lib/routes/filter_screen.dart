import 'package:flutter/material.dart';


import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filter_screen';
  final Map<String, bool> filters;

  final Function _saveFilters;
  FiltersScreen(this._saveFilters, this.filters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isLactoseFree = false;
  @override
  initState() {
    isGlutenFree = widget.filters['gluten'];
    isVegan = widget.filters['vegan'];
    isVegetarian = widget.filters['vegeterian'];
    isLactoseFree = widget.filters['lactose'];

    super.initState();
  }

  Widget _buildListTile(
    String title,
    String description,
    bool currentValue,
    Function update,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20, fontFamily: 'RobotoCondense'),
      ),
      subtitle: Text(description),
      value: currentValue,
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final filterData = {
                'gluten': isGlutenFree,
                'lactose': isLactoseFree,
                'vegan': isVegan,
                'vegeterian': isVegetarian,
              };

              widget._saveFilters(filterData);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 15),
            child: Text('Adjust your meal selections.',
                style: TextStyle(fontFamily: 'RobotoCondense', fontSize: 25)),
          ),
          _buildListTile(
            'Gluten-Free',
            'Only includes gluten-free meals',
            isGlutenFree,
            (newValue) {
              setState(() {
                isGlutenFree = newValue;
              });
            },
          ),
          _buildListTile(
            'Vegan',
            'Only includes vegan meals',
            isVegan,
            (newValue) {
              setState(() {
                isVegan = newValue;
              });
            },
          ),
          _buildListTile(
            'Vegeterian',
            'Only includes vegeterian meals',
            isVegetarian,
            (newValue) {
              setState(() {
                isVegetarian = newValue;
              });
            },
          ),
          _buildListTile(
            'Lactose-Free',
            'Only includes Lactose-free meals',
            isLactoseFree,
            (newValue) {
              setState(() {
                isLactoseFree = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
