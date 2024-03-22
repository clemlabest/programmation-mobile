import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Bienvenue !',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 70),
            child: SvgPicture.asset(
              "ressources/Logo.svg",
              width: 121.85,
              height: 159.68,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 220,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
