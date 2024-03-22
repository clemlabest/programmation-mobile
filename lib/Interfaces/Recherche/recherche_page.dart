import 'package:comics_application/Interfaces/Accueil/container_comics.dart';
import 'package:flutter/material.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF15232E),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            ComicsSectionHeader(),
          ],
        ),
      ),
    );
  }
}
