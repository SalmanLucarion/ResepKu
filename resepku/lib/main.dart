// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/providers/theme_provider.dart';
import 'package:resepku/screens/home_page.dart';
import 'package:resepku/screens/login_page.dart';
import 'package:resepku/screens/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Pastikan binding Flutter siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Cek status login
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'ResepKu',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            brightness: Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.amber,
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode: themeProvider.themeMode, // <-- Tema diatur dari provider

          // --- Logika Rute Baru ---
          initialRoute: isLoggedIn ? '/home' : '/login', // Tentukan halaman awal
          routes: {
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/settings': (context) => const SettingsPage(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}