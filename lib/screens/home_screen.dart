import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
// 🌟 เพิ่ม import ไฟล์หน้าอนิเมะ (เดี๋ยวเราจะสร้างในขั้นตอนที่ 2)
import 'anime_list_screen.dart'; 

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ClipOval(
                child: Image.network(widget.user.avatar, width: 120, height: 120, fit: BoxFit.fill),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome, ${widget.user.fullName}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32), // ปรับระยะห่างนิดหน่อย
              _buildInfoCard(icon: Icons.person, label: 'Username', value: widget.user.username),
              const SizedBox(height: 16),
              _buildInfoCard(icon: Icons.email, label: 'Email', value: widget.user.email),
              
              const SizedBox(height: 40),
              
              // 🌟 เพิ่มปุ่มสำหรับกดไปหน้า API Vercel ของเรา
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // กดแล้วให้เปิดหน้า AnimeListScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AnimeListScreen()),
                    );
                  },
                  icon: const Icon(Icons.movie, color: Colors.white),
                  label: const Text(
                    'Explore Anime',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String label, required String value}) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }
}