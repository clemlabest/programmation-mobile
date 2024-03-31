import 'package:flutter/material.dart';
import '../../API/api.dart';
import 'comics_detail_page.dart'; // Remplacez par le chemin correct de votre page de détails

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
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef'); // Utilisez votre clé API réelle ici
    fetchComics();
  }

  Future<void> fetchComics() async {
    try {
      final data = await apiClient.getEndpointData('issues'); // Assurez-vous que c'est le bon endpoint
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
              padding: const EdgeInsets.all(15),
              itemCount: comicsList.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.transparent, height: 20),
              itemBuilder: (context, index) {
                final comics = comicsList[index];
                final imageInfo = comics['image'] ?? {};
                final thumbnailUrl = imageInfo['small_url'] ?? 'https://placekitten.com/200/300';

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComicsDetailPage(comicsId: comics['id'].toString()),),

                  ),
                  child: Card(
                    color: const Color(0xFF1E3243),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                thumbnailUrl,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comics['name'] ?? 'Titre inconnu',
                                  style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Année : ${comics['start_year'] ?? 'Inconnue'}',
                                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
