import 'package:flutter/material.dart';


import './dummy_data.dart';

import './models/meal.dart';

import './routes/meal_details_screen.dart';
import './routes/tab_screen.dart';
import './routes/categories_screen.dart';
import './routes/category_meal_screen.dart';
import './routes/filter_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meals) {
        if (_filters['gluten'] && !meals.isGlutenFree) return false;
        if (_filters['lactose'] && !meals.isLactoseFree) return false;
        if (_filters['vegan'] && !meals.isVegan) return false;
        if (_filters['vegeterian'] && !meals.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String mealID) {
    return _favoriteMeals.any((meal) => meal.id == mealID);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'RaleWay',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondense',
                fontWeight: FontWeight.w600)),
      ),
      routes: {
        TabsScreen.routeName: (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_availableMeals),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        MealDetails.routeName: (ctx) =>
            MealDetails(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
