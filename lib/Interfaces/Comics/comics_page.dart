import 'package:flutter/material.dart';
import '../../API/api.dart'; // Assurez-vous que cet import pointe vers votre fichier api.dart

class MyComicsPage extends StatefulWidget {
  const MyComicsPage({super.key});

  @override
  _MyComicsPageState createState() => _MyComicsPageState();
}

class _MyComicsPageState extends State<MyComicsPage> {
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
      if (!mounted) return; // Vérifiez si le widget est toujours monté avant de mettre à jour l'état
      setState(() {
        comicsList = data['results'];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return; // Vérifiez aussi ici si le widget est toujours monté
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
              itemCount: comicsList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20), // Plus grand espace entre les éléments
              itemBuilder: (context, index) {
                final comic = comicsList[index];
                final imageInfo = comic['image'] ?? {};
                final thumbnailUrl = imageInfo['small_url'] ?? 'https://placekitten.com/200/300'; // URL par défaut ou une image placeholder
                return Card(
                  color: const Color(0xFF284C6A), // Arrière-plan de l'élément
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Padding intérieur pour la carte
                    child: Row(
                      children: <Widget>[
                        Image.network(thumbnailUrl, width: 100, height: 150, fit: BoxFit.cover), // L'image ne prendra pas toute la carte
                        const SizedBox(width: 10), // Espace entre l'image et le texte
                        Expanded(
                          child: ListTile(
                            title: Text(
                              comic['name'] ?? 'Titre inconnu',
                              style: const TextStyle(fontSize: 17, color: Colors.white), // Taille du titre à 17px
                            ),
                            subtitle: Text(
                              'Issue #${comic['issue_number'].toString()}',
                              style: const TextStyle(color: Colors.white70),
                            ),
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
