import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comics_application/BloC/navigation_bloc.dart';
import 'package:comics_application/BloC/navigation_event.dart';
import 'package:comics_application/BloC/navigation_state.dart';
import 'package:comics_application/Interfaces/bottom_navigation_bar.dart';
import 'package:comics_application/Interfaces/Comics/comics_page.dart';
import 'package:comics_application/Interfaces/Series/series_page.dart';
import 'package:comics_application/Interfaces/Films/films_page.dart';
import 'package:comics_application/Interfaces/Recherche/recherche_page.dart';
// Supposant que CustomHeader est le nouveau widget d'en-tête sans AppBar
import 'package:comics_application/Interfaces/Accueil/appbar.dart';
import 'package:comics_application/Interfaces/Accueil/container_comics.dart';
import 'package:comics_application/Interfaces/Accueil/container_series.dart';
import 'package:comics_application/Interfaces/Accueil/container_films.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          Widget pageContent = const SizedBox(); // Définir une valeur par défaut pour pageContent

          if (state is NavigationInitialState) {
            // Contenu par défaut pour l'accueil
            pageContent = const Column(
              children: [
                CustomHeader(), // Inclure CustomHeader ici pour l'accueil
                Expanded(
                  // Enlever le Padding externe ou ajuster sa valeur selon les besoins
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SeriesSectionHeader(),
                        ComicsSectionHeader(),
                        FilmsSectionHeader(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is NavigationSelectedState) {
            switch (state.selectedIndex) {
              case 1:
                pageContent = const Column(
                  children: [
                    CustomHeader(), // Affiche CustomHeader pour l'onglet Comics
                    Expanded(child: MyComicsPage()),
                  ],
                );
                break;
              case 2:
                pageContent = const Column(
                  children: [
                    CustomHeader(), // Affiche CustomHeader pour l'onglet Comics
                    Expanded(child: MySeriesPage()),
                  ],
                );
                break;
              case 3:
                pageContent = const Column(
                  children: [
                    CustomHeader(), // Affiche CustomHeader pour l'onglet Comics
                    Expanded(child: MyFilmsPage()),
                  ],
                );
                break;
              case 4:
                pageContent = const Column(
                  children: [
                    CustomHeader(), // Affiche CustomHeader pour l'onglet Comics
                    Expanded(child: MySearchPage()),
                  ],
                );
                break;
              default:
                // Contenu par défaut si aucun index connu n'est sélectionné
                pageContent = const Column(
                  children: [
                    CustomHeader(), // Peut-être voulez-vous afficher CustomHeader ici aussi
                    Expanded(
                      // Enlever ou ajuster le Padding externe selon les besoins
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SeriesSectionHeader(),
                            ComicsSectionHeader(),
                            FilmsSectionHeader(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            }
          }

          return pageContent; // Retourne le contenu configuré de la page
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is NavigationSelectedState) {
            selectedIndex = state.selectedIndex;
          }
          return CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onItemTapped: (index) {
              BlocProvider.of<NavigationBloc>(context).add(NavigationTappedEvent(index));
            },
          );
        },
      ),
    );
  }
}





class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Ajuster pour l'espace de la barre de statut
      color: Colors.transparent, // Vous pouvez changer la couleur de fond si nécessaire
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bienvenue !',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SvgPicture.asset(
              "ressources/Logo.svg",
              width: 81.2,
              height: 106.4,
            ),
          ],
        ),
      ),
    );
  }
}



