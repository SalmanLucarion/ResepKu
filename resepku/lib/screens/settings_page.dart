// lib/screens/settings_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/providers/theme_provider.dart';
import 'package:resepku/screens/about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Consumer untuk mendapatkan ThemeProvider
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pengaturan'),
          ),
          body: ListView(
            children: [
              // Opsi Ganti Tema
              SwitchListTile(
                title: const Text('Mode Gelap (Dark Mode)'),
                subtitle: const Text('Aktifkan untuk tampilan gelap'),
                value: themeProvider.themeMode == ThemeMode.dark, // Cek status tema
                onChanged: (bool value) {
                  themeProvider.toggleTheme(value); // Panggil fungsi toggle
                },
                secondary: Icon(themeProvider.themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode),
              ),

              const Divider(),

              // Opsi Halaman Tentang
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Tentang Aplikasi'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}