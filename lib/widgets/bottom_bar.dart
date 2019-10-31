import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final String title;
  final int duration;
  final String affordability;
  final String complexity;

  BottomBar(this.title, this.duration, this.affordability, this.complexity);

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: <Widget>[
        Icon(Icons.schedule),
        SizedBox(
          width: 6,
        ),
        Text('$duration min'),
        SizedBox(
          width: 30,
        ),
        Icon(Icons.work),
        SizedBox(
          width: 6,
        ),
        Text('$complexity'),
        SizedBox(
          width: 30,
        ),
        Icon(Icons.attach_money),
        SizedBox(
          width: 6,
        ),
        Text('$affordability')
      ],
    );
  }
}
