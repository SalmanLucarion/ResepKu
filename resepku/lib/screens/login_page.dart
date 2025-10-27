// lib/screens/login_page.dart

import 'package:flutter/material.dart';
import 'package:resepku/screens/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menyesuaikan warna berdasarkan Tema (Light/Dark)
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final Color fieldColor = isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // Menggunakan MediaQuery untuk padding atas agar lebih dinamis
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // 1. Ikon Chef Hat
              Icon(
                Icons.restaurant_menu, // Ikon pengganti chef hat
                size: 60,
                color: Colors.amber,
              ),
              const SizedBox(height: 24),

              // 2. Teks Welcome Back
              const Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to discover amazing recipes',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 48),

              // 3. Label Email
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),

              // 4. Form Input Email
              TextField(
                decoration: InputDecoration(
                  hintText: 'your@email.com',
                  filled: true,
                  fillColor: fieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // Tanpa border
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // 5. Label Password
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),

              // 6. Form Input Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '********',
                  filled: true,
                  fillColor: fieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 32),

              // 7. Tombol Login
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.amber,
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
                    : const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 8. Link Lupa Password & Daftar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: _isLoading ? null : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      'Daftar di sini',
                      style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}