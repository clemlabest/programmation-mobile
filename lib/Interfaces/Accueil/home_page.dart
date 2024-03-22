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
            pageContent = const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 100), // Ajout d'un padding pour décaler vers le bas
                child: Column(
                  children: [
                    SeriesSectionHeader(),
                    ComicsSectionHeader(),
                    FilmsSectionHeader(),
                  ],
                ),
              ),
            );
          } else if (state is NavigationSelectedState) {
            switch (state.selectedIndex) {
              case 1:
                pageContent = const MyComicsPage();
                break;
              case 2:
                pageContent = const MySeriesPage();
                break;
              case 3:
                pageContent = const MyFilmsPage();
                break;
              case 4:
                pageContent = const MySearchPage();
                break;
              default:
                // Si l'index n'est pas géré, on affiche le contenu par défaut
                pageContent = const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        SeriesSectionHeader(),
                        ComicsSectionHeader(),
                        FilmsSectionHeader(),
                      ],
                    ),
                  ),
                );
            }
          }

          return Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50), // Ajoutez le padding ici si nécessaire pour tout le contenu
                  child: pageContent,
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomHeader(), // Ceci est votre widget en-tête personnalisé
              ),
            ],
          );
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



