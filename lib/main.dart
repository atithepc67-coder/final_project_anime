import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 🌟 1. ตั้งค่าสีหลักเป็นสีฟ้าเข้ม
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A), 
          primary: const Color(0xFF00D1FF),
          brightness: Brightness.dark, 
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // 👈 สีพื้นหลัง
      ),
      home: const LoginScreen(),
    );
  }
}