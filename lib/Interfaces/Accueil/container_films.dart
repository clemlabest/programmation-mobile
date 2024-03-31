import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math; // Importez ce paquet pour utiliser min
import '../../API/api.dart';

class FilmsSectionHeader extends StatefulWidget {
  const FilmsSectionHeader({super.key});

  @override
  FilmsSectionHeaderState createState() => FilmsSectionHeaderState();
}

class FilmsSectionHeaderState extends State<FilmsSectionHeader> {
  late final ComicVineAPI apiClient;
  List<dynamic> moviesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef');
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final data = await apiClient.getEndpointData('movies');
      setState(() {
        moviesList = data['results'];
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
                    'Films populaires',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextButton(
                      onPressed: () {
                        // Logic for viewing more
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
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: math.min(moviesList.length, 5), // Limitez ici le nombre d'éléments à 5
                  itemBuilder: (context, index) {
                    final movie = moviesList[index];
                    final imageInfo = movie['image'] ?? {};
                    final thumbnailUrl = imageInfo['small_url'] ?? 'https://placekitten.com/200/200';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF284C6A),
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(thumbnailUrl, fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  movie['name'] ?? 'Titre inconnu',
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
