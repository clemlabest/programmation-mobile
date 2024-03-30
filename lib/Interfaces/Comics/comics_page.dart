import 'package:flutter/material.dart';
import '../../API/api.dart'; // Assurez-vous que cet import pointe vers votre fichier api.dart

class MyComicsPage extends StatefulWidget {
  const MyComicsPage({super.key});

  @override
  MyComicsPageState createState() => MyComicsPageState();
}

class MyComicsPageState extends State<MyComicsPage> {
  late final ComicVineAPI apiClient;
  List<dynamic> comicsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef'); // Remplacez par votre véritable clé API
    fetchComics();
  }

  Future<void> fetchComics() async {
    try {
      final data = await apiClient.getEndpointData('issues');
      if (!mounted) return;
      setState(() {
        comicsList = data['results'];
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
              padding: const EdgeInsets.all(15), // Padding global pour la liste
              itemCount: comicsList.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.transparent, height: 20),
              itemBuilder: (context, index) {
                final comic = comicsList[index];
                final imageInfo = comic['image'] ?? {};
                final thumbnailUrl = imageInfo['small_url'] ?? 'https://placekitten.com/200/300';
                
                return Card(
                  color: const Color(0xFF1E3243),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start of the row
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10), // Ajout du padding autour de l'image
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10), // Bords arrondis avec un radius de 10
                                child: Image.network(
                                  thumbnailUrl, 
                                  width: 140, // Largeur fixée
                                  height: 140, // Hauteur fixée pour garder un aspect carré
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
                                  borderRadius: BorderRadius.circular(20), // Plus arrondi pour un ovale
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
                        const SizedBox(width: 15), // Espacement entre l'image et le texte
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Aligner le texte à gauche
                            children: [
                              Text(
                                comic['name'] ?? 'Titre inconnu',
                                style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5), // Petit espace entre le titre et le sous-titre
                              Text(
                                'Issue #${comic['issue_number'].toString()}',
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
