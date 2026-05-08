import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  final String apiUrl = 'https://final-project-anime.vercel.app/api/anime';
  
  List<dynamic> _animeList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAnime();
  }

  Future<void> _fetchAnime() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _animeList = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color midnightBG = Color(0xFF0F172A);
    const Color surfaceBlue = Color(0xFF1B2A4E);
    const Color electricCyan = Color(0xFF00D1FF);

    return Scaffold(
      backgroundColor: midnightBG,
      appBar: AppBar(
        backgroundColor: surfaceBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: electricCyan),
        title: const Text('Anime Explorer', style: TextStyle(color: electricCyan, fontWeight: FontWeight.bold)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: electricCyan))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _animeList.length,
              itemBuilder: (context, index) {
                final anime = _animeList[index];
                return Card(
                  color: surfaceBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: electricCyan.withValues(alpha: 0.1), width: 1),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 5, offset: const Offset(2, 2)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          anime['coverimage'],
                          width: 65,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.movie, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(
                      anime['name'], 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '⭐ ${anime['rating']}  |  🎬 ${anime['episodes']} EPS',
                        style: const TextStyle(color: electricCyan, fontWeight: FontWeight.w500),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: electricCyan),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: surfaceBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: electricCyan, width: 1.5),
                          ),
                          title: Text(anime['name'], style: const TextStyle(color: electricCyan, fontWeight: FontWeight.bold)),
                          content: Text(anime['detail'], style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), 
                              child: const Text('CLOSE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}