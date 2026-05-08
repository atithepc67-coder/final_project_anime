import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });

      final response = await _authService.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      setState(() { _isLoading = false; });

      if (response.isValid) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: response.user!),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message, style: const TextStyle(color: Colors.white)), 
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color midnightBG = Color(0xFF0F172A);
    const Color surfaceBlue = Color(0xFF1B2A4E);
    const Color electricCyan = Color(0xFF00D1FF);

    return Scaffold(
      backgroundColor: midnightBG,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: surfaceBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: electricCyan.withValues(alpha: 0.3), // 👈 แก้ตรงนี้
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, size: 60, color: electricCyan),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Anime Explorer',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unlock the world of Anime',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.person_outline, color: electricCyan),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: surfaceBlue.withValues(alpha: 0.5)), // 👈 แก้ตรงนี้
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: electricCyan, width: 2),
                      ),
                      filled: true,
                      fillColor: surfaceBlue,
                    ),
                    validator: (value) => value!.isEmpty ? 'Please enter your username' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.lock_outline, color: electricCyan),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: surfaceBlue.withValues(alpha: 0.5)), // 👈 แก้ตรงนี้
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: electricCyan, width: 2),
                      ),
                      filled: true,
                      fillColor: surfaceBlue,
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: electricCyan,
                        foregroundColor: midnightBG,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        shadowColor: electricCyan.withValues(alpha: 0.5), // 👈 แก้ตรงนี้
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading 
                          ? const CircularProgressIndicator(color: midnightBG)
                          : const Text(
                              'LOGIN TO EXPLORE', 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0)
                            ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Developed with 💙 on Mac Air M3 by Atithep Choosuwan\nStudent ID: 6706896', 
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}