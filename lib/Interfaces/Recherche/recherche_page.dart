import 'package:flutter/material.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: Column(
        children: [
          const SizedBox(height: 40), // Ajoutez un espace en haut
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Comic, film, série...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Affichez vos résultats de recherche ici
                  // Vous pouvez créer des widgets dynamiquement basés sur searchText
                  // Par exemple:
                  if (searchText.contains('comics'))
                    ...[ /* Vos widgets comics ici basés sur la recherche */ ],
                  if (searchText.contains('films'))
                    ...[ /* Vos widgets films ici basés sur la recherche */ ],
                  if (searchText.contains('séries'))
                    ...[ /* Vos widgets séries ici basés sur la recherche */ ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
