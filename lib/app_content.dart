import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildHomePage() {
  return MaterialApp(
    title: 'comics_application',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  Widget _buildSvgIcon(String assetName, int index) {
    return SvgPicture.asset(
      assetName,
      width: 24.01,
      height: 24.01,
      color: _selectedIndex == index ? const Color(0xFF12273C) : const Color(0xFF778BA8),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E3243),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Séries populaires',
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
  decoration: BoxDecoration(
    color: const Color(0xFF0F1921).withOpacity(0.5), // Ajout d'une opacité de 50%
    borderRadius: BorderRadius.circular(10),
  ),
  child: TextButton(
    onPressed: () {
      // Action pour "Voir plus"
    },
    child: Text(
      'Voir plus',
      style: GoogleFonts.nunito(color: Colors.white),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Bienvenue !',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SvgPicture.asset(
              "ressources/Logo.svg",
              width: 121.85,
              height: 159.68,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionHeader(context, "Séries populaires"),
            // Ajoutez ici d'autres widgets pour les séries
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildSvgIcon("ressources/BottomNavigationBar/ic_home.svg", 0),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("ressources/BottomNavigationBar/ic_books.svg", 1),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("ressources/BottomNavigationBar/ic_tv.svg", 2),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("ressources/BottomNavigationBar/ic_movie.svg", 3),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon("ressources/BottomNavigationBar/ic_search.svg", 4),
            label: 'Recherche',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF12273C),
        unselectedItemColor: const Color(0xFF778BA8),
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF0F1E2B),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}