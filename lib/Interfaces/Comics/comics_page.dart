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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF15232E),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            ComicsSectionHeader(),
            // Ici, vous pouvez ajouter d'autres widgets pour le contenu de votre page
          ],
        ),
      ),
       // Utilisez CustomBottomNavigationBar pour la barre de navigation inférieure
    );
  }
}