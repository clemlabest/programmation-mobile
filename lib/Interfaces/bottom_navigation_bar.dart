import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comics_application/BloC/navigation_bloc.dart';
import 'package:comics_application/BloC/navigation_event.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Widget _buildSvgIcon(BuildContext context, String assetName, int index) {
  return SvgPicture.asset(
    assetName,
    width: 24.0,
    height: 24.0,
    colorFilter: ColorFilter.mode(
      selectedIndex == index ? const Color(0xFF12273C) : const Color(0xFF778BA8),
      BlendMode.srcIn,
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      context.read<NavigationBloc>().add(NavigationTappedEvent(index));
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F1E2B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
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
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
