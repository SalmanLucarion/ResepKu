// lib/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:resepku/screens/search_page.dart'; // <-- 1. IMPORT HALAMAN SEARCH BARU
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resepku/screens/login_page.dart';
import 'package:resepku/screens/settings_page.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';
import 'recipe_list_page.dart';
import 'recipe_detail_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  final RecipeService _recipeService = RecipeService();
  final TextEditingController _searchController = TextEditingController(); // Controller

  final List<String> _categories = ['Breakfast', 'Dessert', 'Seafood', 'Chicken'];
  final Map<String, IconData> categoryIcons = {
    'Breakfast': Icons.free_breakfast_outlined,
    'Dessert': Icons.cake_outlined,
    'Seafood': Icons.set_meal_outlined,
    'Chicken': Icons.kebab_dining_outlined,
  };

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecipes() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    try {
      // Memuat dari service (yang mengambil dari dummy_recipes.json)
      final recipes = await _recipeService.loadRecipes();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load recipes: $e');
    }
  }

  // (Widget Shimmer tidak berubah)
  Widget _buildLoadingShimmer() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 30, width: 200, color: Colors.white),
              const SizedBox(height: 8),
              Container(height: 20, width: 250, color: Colors.white),
              const SizedBox(height: 24),
              Container(height: 50, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
              const SizedBox(height: 24),
              Container(height: 24, width: 100, color: Colors.white),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => Container(margin: const EdgeInsets.only(right: 8), height: 40, width: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
                ),
              ),
              const SizedBox(height: 24),
              Container(height: 180, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15))),
              const SizedBox(height: 24),
              Container(height: 24, width: 150, color: Colors.white),
              const SizedBox(height: 16),
              Container(height: 80, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
            ],
          ),
        ),
      ),
    );
  }

  // (Widget Banner Resep Pilihan tidak berubah)
  Widget _buildFeaturedCard(BuildContext context, Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipe: recipe, isFromApi: false),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              recipe.imageURL,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.35),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.id == "1" ? 'RESEP PILIHAN HARI INI' : 'JUGA POPULER',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // (Widget Drawer Menu tidak berubah)
  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Pengguna ResepKu"),
            accountEmail: Text("pengguna@resepku.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "P",
                style: TextStyle(fontSize: 40.0, color: Colors.amber),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan Akun'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Recipe> featuredRecipes = _recipes.isNotEmpty ? _recipes.take(2).toList() : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ResepKu', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ],
      ),
      drawer: _buildAppDrawer(context),
      body: _isLoading
          ? _buildLoadingShimmer()
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ## Header ##
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Halo, Pengguna!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Mau masak apa hari ini?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),

              // ## Search Bar Fungsional (DUMMY DATA) ##
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController, // Set controller
                  decoration: InputDecoration(
                    hintText: 'Cari resep masakan...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.grey[800],
                  ),
                  // --- INI PERUBAHAN UTAMANYA ---
                  onSubmitted: (String query) {
                    if (query.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // Arahkan ke SearchPage baru kita
                          builder: (context) => SearchPage(query: query),
                        ),
                      );
                      _searchController.clear();
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),

              // ## Kategori ##
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kategori',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final categoryName = _categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        avatar: Icon(
                          categoryIcons[categoryName] ?? Icons.restaurant_menu,
                          size: 18,
                        ),
                        label: Text(categoryName),
                        backgroundColor: Theme.of(context).brightness == Brightness.light
                            ? Colors.amber.withOpacity(0.1)
                            : Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeListPage(category: categoryName),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // ## Carousel Swiper ##
              if (featuredRecipes.isNotEmpty)
                SizedBox(
                  height: 200, // Tinggi Swiper + Paginasi
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildFeaturedCard(context, featuredRecipes[index]),
                      );
                    },
                    itemCount: featuredRecipes.length,
                    autoplay: true,
                    autoplayDelay: 5000,
                    viewportFraction: 1.0, // Tampilkan penuh
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.all(16.0),
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: Colors.amber,
                        size: 8.0,
                        activeSize: 10.0,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              // ## Resep Populer ##
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Resep Populer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(recipe: recipe, isFromApi: false),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  recipe.imageURL,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(recipe.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(recipe.category, style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}