// lib/screens/search_page.dart

import 'package:flutter/material.dart';
import 'package:resepku/models/recipe_model.dart';
import 'package:resepku/services/recipe_service.dart';
import 'package:resepku/screens/recipe_detail_page.dart';
import 'package:shimmer/shimmer.dart'; // Kita juga pakai shimmer di sini

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RecipeService _recipeService = RecipeService();
  late Future<List<Recipe>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _loadAndFilterRecipes();
  }

  Future<List<Recipe>> _loadAndFilterRecipes() async {
    // 1. Muat SEMUA resep dari file dummy JSON
    final allRecipes = await _recipeService.loadRecipes();

    // 2. Filter resep secara lokal
    final filteredList = allRecipes.where((recipe) {
      // Cek apakah nama resep mengandung query (tidak case-sensitive)
      return recipe.name.toLowerCase().contains(widget.query.toLowerCase());
    }).toList();

    return filteredList;
  }

  // Widget Shimmer (sama seperti di RecipeListPage)
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
        title: Text('Hasil untuk: "${widget.query}"'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingShimmer();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Resep tidak ditemukan.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // Tampilkan hasil
          final recipes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return GestureDetector(
                onTap: () {
                  // PENTING: kirim 'isFromApi: false'
                  // karena ini dari data dummy
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailPage(
                        recipe: recipe,
                        isFromApi: false,
                      ),
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
                        // Gunakan Image.asset karena dari data dummy
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
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}