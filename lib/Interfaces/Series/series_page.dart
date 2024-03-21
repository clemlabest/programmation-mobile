// my_home_page.dart
import 'package:comics_application/Interfaces/Accueil/container_comics.dart';
import 'package:comics_application/Interfaces/Accueil/container_films.dart';
import 'package:comics_application/Interfaces/Accueil/container_series.dart';
import 'package:flutter/material.dart';
import '../bottom_navigation_bar.dart'; // Importez le fichier de la barre de navigation personnalisée

class MySeriesPage extends StatefulWidget {
  const MySeriesPage({super.key});

  @override
  _MySeriesPageState createState() => _MySeriesPageState();
}

class _MySeriesPageState extends State<MySeriesPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF15232E),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            SeriesSectionHeader(),
            // Ici, vous pouvez ajouter d'autres widgets pour le contenu de votre page
          ],
        ),
      ),
       // Utilisez CustomBottomNavigationBar pour la barre de navigation inférieure
    );
  }
}
