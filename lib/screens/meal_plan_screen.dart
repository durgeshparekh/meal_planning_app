import 'package:flutter/material.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start a new meal plan'),
      ),
      body: Center(
        child: Text('Meal Plan Screen'),
      ),
    );
  }
}
