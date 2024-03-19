import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeriesSectionHeader extends StatelessWidget {
  const SeriesSectionHeader({super.key});

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
            // Ajout d'un Row pour le cercle et le texte
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Le cercle orange
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.only(right: 8.0), // Espacement entre le cercle et le texte
                ),
                // Le texte
                Text(
                  'Séries populaires',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            // Le bouton "Voir plus" reste inchangé
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
