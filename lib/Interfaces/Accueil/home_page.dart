// my_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comics_application/BloC/navigation_bloc.dart';
import 'package:comics_application/BloC/navigation_event.dart';
import 'package:comics_application/Interfaces/Accueil/appbar.dart';
import 'package:comics_application/Interfaces/bottom_navigation_bar.dart';
import 'package:comics_application/BloC/navigation_state.dart';
import 'package:comics_application/Interfaces/Comics/comics_page.dart';
import 'package:comics_application/Interfaces/Series/series_page.dart';
import 'package:comics_application/Interfaces/Accueil/container_comics.dart';
import 'package:comics_application/Interfaces/Accueil/container_series.dart';
import 'package:comics_application/Interfaces/Accueil/container_films.dart';
// Include additional imports for FilmsPage and SearchPage if necessary

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      appBar: const CustomAppBar(),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          // Pour l'état initial, affichez le contenu de base
          if (state is NavigationInitialState || state is NavigationSelectedState && state.selectedIndex == 0) {
            return const SingleChildScrollView(
              child: Column(
                children: [
                  SeriesSectionHeader(),
                  ComicsSectionHeader(),
                  FilmsSectionHeader(),
                ],
              ),
            );
          }

          // Pour les autres états sélectionnés, naviguez vers les pages spécifiques
          else if (state is NavigationSelectedState) {
            switch (state.selectedIndex) {
              case 1:
                return const MyComicsPage();
              case 2:
                return const MySeriesPage();
              // Ajoutez d'autres cas pour Films et Recherche ici
              default:
                return Container(); // Ou une page d'erreur/not found
            }
          }

          // Pour tout autre état non géré
          else {
            return Container(); // Ou une page d'erreur/not found
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int selectedIndex = state is NavigationSelectedState ? state.selectedIndex : 0;
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


// Make sure the MyComicsPage, MySeriesPage, and other classes are correctly defined 
// in their respective files and correctly imported here.
