// my_home_page.dart
import 'package:comics_application/container_comics.dart';
import 'package:comics_application/container_films.dart';
import 'package:flutter/material.dart';
import 'appbar.dart'; // Assurez-vous que CustomAppBar est défini et importé
import 'container_series.dart'; // Assurez-vous que SeriesSectionHeader est défini et importé
import 'bottom_navigation_bar.dart'; // Importez le fichier de la barre de navigation personnalisée

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      appBar: const CustomAppBar(), // Utilisez CustomAppBar pour votre app bar
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SeriesSectionHeader(), // Utilisez SeriesSectionHeader pour l'en-tête de section
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
