import 'package:flutter/material.dart';

class SearchRecipesScreen extends StatelessWidget {
  const SearchRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for new recipes'),
      ),
      body: Center(
        child: Text('Search Recipes Screen'),
      ),
    );
  }
}
