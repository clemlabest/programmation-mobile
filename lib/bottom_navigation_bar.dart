// bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, "ressources/BottomNavigationBar/ic_home.svg", 0),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, "ressources/BottomNavigationBar/ic_books.svg", 1),
          label: 'Comics',
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, "ressources/BottomNavigationBar/ic_tv.svg", 2),
          label: 'Séries',
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, "ressources/BottomNavigationBar/ic_movie.svg", 3),
          label: 'Films',
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(context, "ressources/BottomNavigationBar/ic_search.svg", 4),
          label: 'Recherche',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFF12273C),
      unselectedItemColor: const Color(0xFF778BA8),
      onTap: onItemTapped,
      backgroundColor: const Color(0xFF0F1E2B),
      type: BottomNavigationBarType.fixed,
    );
  }

  Widget _buildSvgIcon(BuildContext context, String assetName, int index) {
  return SvgPicture.asset(
    assetName,
    width: 24.0,
    height: 24.0,
    color: selectedIndex == index ? const Color(0xFF12273C) : const Color(0xFF778BA8),
  );
}
}

