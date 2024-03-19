// series_section_header.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeriesSectionHeader extends StatelessWidget {
  const SeriesSectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                color: const Color(0xFF0F1921).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {},
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
}
