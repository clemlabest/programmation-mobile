import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../API/api.dart'; // Assurez-vous que cet import pointe vers votre fichier api.dart

class ComicsSectionHeader extends StatefulWidget {
  const ComicsSectionHeader({super.key});

  @override
  _ComicsSectionHeaderState createState() => _ComicsSectionHeaderState();
}

class _ComicsSectionHeaderState extends State<ComicsSectionHeader> {
  late final ComicVineAPI apiClient;
  List<dynamic> comicsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef');
    fetchComics();
  }

  Future<void> fetchComics() async {
    try {
      final data = await apiClient.getEndpointData('issues');
      setState(() {
        comicsList = data['results'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E3243),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  Text(
                    'Comics populaires',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(), // This will push the button to the end of the Row
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0), // Increased space before the button
                    child: TextButton(
                      onPressed: () {
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: const Color(0xFF0F1921).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Voir plus',
                        style: GoogleFonts.nunito(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
  const CircularProgressIndicator()
else
  SizedBox(
    height: 200, // Hauteur de votre liste
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: comicsList.length,
      itemBuilder: (context, index) {
        final comic = comicsList[index];
        final imageInfo = comic['image'] ?? {};
        final thumbnailUrl = imageInfo['thumb_url'] ?? 'https://placekitten.com/200/200'; // Une image de remplacement en carré

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espacement entre les cartes de comics
          child: Container(
            width: 140, // La largeur de chaque conteneur de comic
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF284C6A), // Couleur de fond de l'élément
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.0, // L'image sera carrée
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Arrondir les coins de l'image
                    child: Image.network(
                      thumbnailUrl,
                      fit: BoxFit.cover, // Cela permet de couvrir tout l'espace disponible
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      comic['name'] ?? 'Titre inconnu',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  ),
          ],
        ),
      ),
    );
  }
}
