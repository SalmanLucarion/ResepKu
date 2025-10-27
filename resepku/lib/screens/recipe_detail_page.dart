// lib/screens/recipe_detail_page.dart

import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  final bool isFromApi;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
    this.isFromApi = false,
  });

  @override
  Widget build(BuildContext context) {
    // Menyesuaikan warna berdasarkan Tema
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDarkMode ? Colors.grey[850]! : Colors.grey.shade100;

    return Scaffold(
      // AppBar sederhana
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Gambar Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: isFromApi
                    ? Image.network(
                  recipe.imageURL,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                )
                    : Image.asset(
                  recipe.imageURL,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2. Konten di bawah gambar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3. Tags (Contoh: "Healthy", "Easy")
                  _buildTags(recipe.tags),
                  const SizedBox(height: 12),

                  // 4. Judul Resep
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 5. Deskripsi
                  Text(
                    recipe.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6. Info Row (Cook Time, Servings, Difficulty)
                  _buildInfoRow(
                    context,
                    cookTime: recipe.cookTime,
                    servings: recipe.servings,
                    difficulty: recipe.difficulty,
                  ),
                  const SizedBox(height: 24),

                  // 7. Nutrition Facts (Gaya dari image_e58600.png)
                  _buildSectionTitle('Nutrition Facts'),
                  _buildNutritionCard(context, recipe.nutrition, cardColor),
                  const SizedBox(height: 24),

                  // 8. Ingredients (Gaya dari image_e585a8.png)
                  _buildSectionTitle('Ingredients'),
                  _buildIngredientList(context, recipe.ingredients, cardColor),
                  const SizedBox(height: 24),

                  // 9. Instructions (Gaya dari image_e58600.png)
                  _buildSectionTitle('Instructions'),
                  _buildInstructionList(recipe.instructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER BARU ---

  // Helper untuk Tags
  Widget _buildTags(List<String> tags) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags.map((tag) => Chip(
        label: Text(tag),
        backgroundColor: Colors.amber.shade100,
        labelStyle: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
      )).toList(),
    );
  }

  // Helper untuk Info Row
  Widget _buildInfoRow(BuildContext context, {required String cookTime, required String servings, required String difficulty}) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoItem(context, Icons.timer_outlined, 'Cook Time', cookTime),
          const VerticalDivider(),
          _buildInfoItem(context, Icons.people_outline, 'Servings', servings),
          const VerticalDivider(),
          _buildInfoItem(context, Icons.kitchen_outlined, 'Difficulty', difficulty),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.amber),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper untuk Nutrition Card (Gaya image_e58600.png)
  Widget _buildNutritionCard(BuildContext context, Map<String, String> nutrition, Color cardColor) {
    return Card(
      elevation: 0,
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: nutrition.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  Text(entry.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Helper untuk Judul Seksi (Bahan & Instruksi)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper untuk Ingredient List (Gaya image_e585a8.png)
  Widget _buildIngredientList(BuildContext context, List<String> ingredients, Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 10, color: Colors.amber),
                const SizedBox(width: 12),
                Expanded(child: Text(ingredients[index], style: const TextStyle(fontSize: 16))),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper untuk Instruction List (Gaya image_e58600.png)
  Widget _buildInstructionList(List<String> instructions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: instructions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.amber,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0), // Menyamakan posisi teks
                  child: Text(instructions[index], style: const TextStyle(fontSize: 16, height: 1.4)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}