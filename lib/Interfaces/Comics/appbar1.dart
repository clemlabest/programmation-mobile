import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Ajustez la valeur pour déplacer le texte vers la droite
            child: Text(
              'Comics les plus\npopulaires',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 220, // Assurez-vous que cette hauteur est suffisante pour l'image
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90); // Assurez-vous que cette hauteur correspond à la hauteur de votre AppBar
}