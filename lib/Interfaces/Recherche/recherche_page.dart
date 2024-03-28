import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: SingleChildScrollView(
        // Le SingleChildScrollView permettra à votre contenu de défiler s'il dépasse l'écran
        child: Column(
          children: [
            // ClipRRect est utilisé pour arrondir les coins inférieurs du conteneur
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: const Color(0xFF1E3243), // Couleur de fond pour la barre de recherche
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0, // Espace en haut
                    left: 16.0, // Espace à gauche
                    right: 16.0, // Espace à droite
                    bottom: 16.0, // Espace en bas pour délimiter la zone de recherche
                  ),
                  child: Column(
                    children: [
                      // Texte "Recherche"
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0), // Espace en dessous du texte "Recherche"
                          child: Text(
                            'Recherche',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Barre de recherche TextField
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1), // Opacité pour la barre de recherche
                          hintText: 'Comic, film, série...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Ajoutez le reste de votre contenu ici. S'il doit être dans le fond bleu, incluez-le dans le Column ci-dessus.
            // ...
          ],
        ),
      ),
    );
  }
}