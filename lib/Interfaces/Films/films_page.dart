import 'package:comics_application/Interfaces/Accueil/container_Films.dart';
import 'package:flutter/material.dart';

class MyFilmsPage extends StatefulWidget {
  const MyFilmsPage({super.key});

  @override
  _MyFilmsPageState createState() => _MyFilmsPageState();
}

class _MyFilmsPageState extends State<MyFilmsPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF15232E),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            FilmsSectionHeader(),
          ],
        ),
      ),
    );
  }
}
