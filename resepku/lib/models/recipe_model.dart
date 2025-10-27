// lib/models/recipe_model.dart

class Recipe {
  final String id;
  final String name;
  final String category;
  final String imageURL;
  final List<String> ingredients;
  final List<String> instructions;

  // --- DATA BARU ---
  final String description;
  final List<String> tags;
  final String cookTime;
  final String servings;
  final String difficulty;
  final Map<String, String> nutrition;
  // --- BATAS DATA BARU ---

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.imageURL,
    required this.ingredients,
    required this.instructions,
    // --- DATA BARU ---
    required this.description,
    required this.tags,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    required this.nutrition,
  });

  // Factory untuk JSON dummy (assets/dummy_recipes.json)
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      name: json['name'],
      category: json['category'],
      imageURL: json['imageURL'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      // --- DATA BARU ---
      description: json['description'],
      tags: List<String>.from(json['tags']),
      cookTime: json['cookTime'],
      servings: json['servings'],
      difficulty: json['difficulty'],
      nutrition: Map<String, String>.from(json['nutrition']),
    );
  }

  // Factory untuk JSON dari API (TheMealDB)
  factory Recipe.fromJsonApi(Map<String, dynamic> json) {
    List<String> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsList.add(ingredient);
      }
    }

    // Data dummy untuk field yang tidak ada di API
    return Recipe(
        id: json['idMeal'],
        name: json['strMeal'],
        category: json['strCategory'],
        imageURL: json['strMealThumb'],
        instructions: (json['strInstructions'] as String).split('\r\n'),
        ingredients: ingredientsList,
        // --- DATA BARU (DUMMY) ---
        description: "A delicious and flavorful dish from TheMealDB. ${json['strInstructions'].substring(0, 100)}...",
        tags: (json['strTags'] as String?)?.split(',') ?? [json['strCategory']],
        cookTime: "30 min",
        servings: "2 people",
        difficulty: "Medium",
        nutrition: {
          "Calories": "450", "Protein": "30g", "Fat": "15g", "Carbs": "25g"
        }
    );
  }
}