import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.network(recipe['image'], fit: BoxFit.cover),
        title: Text(recipe['title']),
        subtitle: Text('Ready in ${recipe['readyInMinutes']} mins'),
      ),
    );
  }
}
