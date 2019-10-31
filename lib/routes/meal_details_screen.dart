import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetails extends StatelessWidget {
  static const String routeName = '/meal_details';
  final Function _toggleFavorite;
  final Function isMealFavorite;

  MealDetails(this._toggleFavorite, this.isMealFavorite);

  Widget buildTextSection(BuildContext context, text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildChildSection(child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 350,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);

    return Scaffold(
        appBar: AppBar(title: Text(selectedMeal.title)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildTextSection(context, 'Ingredients'),
              buildChildSection(
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).splashColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildTextSection(context, 'Steps'),
              buildChildSection(
                ListView.builder(
                    itemBuilder: (ctx, index) => Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(selectedMeal.steps[index]),
                            ),
                            Divider(),
                          ],
                        ),
                    itemCount: selectedMeal.steps.length),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            isMealFavorite(mealID) ? Icons.star : Icons.star_border,
          ),
          onPressed: () => _toggleFavorite(mealID),
        ));
  }
}
