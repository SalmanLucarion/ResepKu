// lib/services/recipe_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:resepku/models/recipe_model.dart';
import 'package:http/http.dart' as http; // <-- 1. IMPORT HTTP

class RecipeService {
  // API untuk 'Resep Populer' di HomePage (menggunakan data dummy)
  Future<List<Recipe>> loadRecipes() async {
    final String jsonString = await rootBundle.loadString('assets/dummy_recipes.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> recipeListJson = jsonMap['recipes'];
    return recipeListJson.map((json) => Recipe.fromJson(json)).toList();
  }

  // --- 2. FUNGSI BARU UNTUK PENCARIAN ---
  final String _searchBaseUrl = "https://www.themealdb.com/api/json/v1/1/search.php?s=";

  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(Uri.parse(_searchBaseUrl + query));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // API mengembalikan 'meals: null' jika tidak ditemukan
      if (jsonResponse['meals'] == null) {
        return []; // Kembalikan daftar kosong
      }

      final List<dynamic> meals = jsonResponse['meals'];

      // Kita perlu menyesuaikan parsing JSON dari API
      return meals.map((json) => Recipe.fromJsonApi(json)).toList();
    } else {
      throw Exception('Gagal memuat hasil pencarian dari API');
    }
  }
}