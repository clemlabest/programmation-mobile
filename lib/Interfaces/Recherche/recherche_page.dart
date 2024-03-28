import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with search
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: const Color(0xFF1E3243),
                padding: const EdgeInsets.only(
                  top: 16.0, // Top padding
                  left: 16.0, // Left padding
                  right: 16.0, // Right padding
                  bottom: 24.0, // Adjust bottom padding to create space for the search bar
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 24), // Space between the title and the search bar
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
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
            // Rest of the page content
            // ...
          ],
        ),
      ),
    );
  }
}
