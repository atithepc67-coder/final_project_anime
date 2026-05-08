import 'package:flutter/material.dart';
import '../models/user.dart'; // ตรวจสอบ path ให้ตรงกับของคุณนะครับ
import 'anime_list_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const Color midnightBG = Color(0xFF0F172A);
    const Color surfaceBlue = Color(0xFF1B2A4E);
    const Color electricCyan = Color(0xFF00D1FF);

    return Scaffold(
      backgroundColor: midnightBG,
      appBar: AppBar(
        backgroundColor: midnightBG,
        elevation: 0,
        title: const Text('My Profile', style: TextStyle(color: electricCyan, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🌟 กรอบรูปโปรไฟล์เรืองแสง
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [electricCyan, Colors.deepPurpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: electricCyan.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.avatar),
                  backgroundColor: surfaceBlue,
                ),
              ),
              const SizedBox(height: 30),
              
              // 🌟 การ์ดข้อมูล User
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceBlue,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: electricCyan.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${user.fname} ${user.lname}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // 👇 เพิ่มแถบอีเมลตรงนี้
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: midnightBG,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.username, // แสดงอีเมลของอาจารย์
                        style: const TextStyle(fontSize: 14, color: electricCyan, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // 🌟 ปุ่มไปหน้า Anime
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: electricCyan,
                    foregroundColor: midnightBG,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 10,
                    shadowColor: electricCyan.withValues(alpha: 0.5),
                  ),
                  icon: const Icon(Icons.movie_creation_rounded),
                  label: const Text(
                    'EXPLORE ANIME',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AnimeListScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}