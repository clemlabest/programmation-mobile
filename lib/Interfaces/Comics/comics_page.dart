// my_home_page.dart
import 'package:comics_application/Interfaces/Accueil/container_comics.dart';
import 'package:comics_application/Interfaces/Accueil/container_films.dart';
import 'package:flutter/material.dart';
import '../bottom_navigation_bar.dart'; // Importez le fichier de la barre de navigation personnalisée

class MyComicsPage extends StatefulWidget {
  const MyComicsPage({super.key});

  @override
  _MyComicsPageState createState() => _MyComicsPageState();
}

class _MyComicsPageState extends State<MyComicsPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
    
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ComicsSectionHeader(),
            FilmsSectionHeader(),
            // Ici, vous pouvez ajouter d'autres widgets pour le contenu de votre page
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ), // Utilisez CustomBottomNavigationBar pour la barre de navigation inférieure
    );
  }
}
