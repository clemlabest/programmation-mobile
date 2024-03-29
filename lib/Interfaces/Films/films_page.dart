import 'package:flutter/material.dart';
import '../../API/api.dart'; // Assurez-vous que cet import pointe vers votre fichier api.dart

class MyFilmsPage extends StatefulWidget {
  const MyFilmsPage({super.key});

  @override
  _MyFilmsPageState createState() => _MyFilmsPageState();
}

class _MyFilmsPageState extends State<MyFilmsPage> {
  late final ComicVineAPI apiClient;
  List<dynamic> moviesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef'); // Remplacez 'votre_clé_api' par votre clé API réelle
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final data = await apiClient.getEndpointData('movies'); // Assurez-vous que 'movies' est le bon endpoint
      if (!mounted) return;
      setState(() {
        moviesList = data['results'];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: moviesList.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.transparent, height: 20),
              itemBuilder: (context, index) {
                final movie = moviesList[index];
                final imageInfo = movie['image'] ?? {};
                final thumbnailUrl = imageInfo['small_url'] ?? 'https://placekitten.com/200/300';
                
                return Card(
                  color: const Color(0xFF1E3243),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  thumbnailUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 227, 139, 9),
                                  borderRadius: BorderRadius.circular(20), // Plus arrondi pour un ovale                                 ),
                                ),
                                child: Text(
                                  '#${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['name'] ?? 'Titre inconnu',
                                style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Année : ${movie['start_year'] ?? 'Inconnue'}',
                                style: const TextStyle(fontSize: 15, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
