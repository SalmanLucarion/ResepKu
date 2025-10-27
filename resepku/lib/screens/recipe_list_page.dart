// lib/screens/recipe_list_page.dart

import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';
import 'recipe_detail_page.dart';
import 'package:shimmer/shimmer.dart'; // Pastikan import ini benar

class RecipeListPage extends StatefulWidget {
  final String category;
  const RecipeListPage({super.key, required this.category});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> _filteredRecipes = [];
  bool _isLoading = true;
  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    _loadAndFilterRecipes();
  }

  Future<void> _loadAndFilterRecipes() async {
    await Future.delayed(const Duration(milliseconds: 1500)); // Jeda untuk pamer shimmer
    try {
      final allRecipes = await _recipeService.loadRecipes();
      final filteredList = allRecipes.where((recipe) {
        return recipe.category.toLowerCase() == widget.category.toLowerCase();
      }).toList();

      setState(() {
        _filteredRecipes = filteredList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load or filter recipes: $e');
    }
  }

  // Widget Shimmer untuk loading
  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(height: 24, width: 200, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _isLoading
          ? _buildLoadingShimmer() // Gunakan Shimmer
          : _filteredRecipes.isEmpty
          ? const Center(
        child: Text(
          'Tidak ada resep di kategori ini.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _filteredRecipes.length,
        itemBuilder: (context, index) {
          final recipe = _filteredRecipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipe: recipe),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      recipe.imageURL,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}