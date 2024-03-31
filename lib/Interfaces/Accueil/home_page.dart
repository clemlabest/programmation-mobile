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
          String headerTitle;
          bool showSearchBar = false;
          bool showLogo = false;
          
          if (state is NavigationInitialState) {
            headerTitle = 'Bienvenue !';
            showLogo = true;
          } else if (state is NavigationSelectedState) {
            switch (state.selectedIndex) {
              case 1:
                headerTitle = 'Comics les plus \npopulaires';
                break;
              case 2:
                headerTitle = 'Séries les plus \npopulaires';
                break;
              case 3:
                headerTitle = 'Films les plus \npopulaires';
                break;
              case 4:
                headerTitle = 'Recherche';
                showSearchBar = true;
                break;
              default:
                headerTitle = 'Bienvenue !';
                showLogo = true;
                break;
            }
          } else {
            headerTitle = 'Bienvenue !';
            showLogo = true;
          }

          Widget mainPageContent;
          if (state is NavigationSelectedState) {
            switch (state.selectedIndex) {
              case 1:
                mainPageContent = const MyComicsPage();
                break;
              case 2:
                mainPageContent = const MySeriesPage();
                break;
              case 3:
                mainPageContent = const MyFilmsPage();
                break;
              case 4:
                mainPageContent = const MySearchPage();
                break;
              default:
                mainPageContent = const Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ComicsSectionHeader(),
                            SeriesSectionHeader(),
                            FilmsSectionHeader(),
                                    ]
                            )
                            )
                            )
                            ]
                            );
                break;
            }
          } else {
            mainPageContent = const Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SeriesSectionHeader(),
                            ComicsSectionHeader(),
                            FilmsSectionHeader(),
                                    ]
                            )
                            )
                            )
                            ]
                            );
          }

          return Column(
            children: [
              if (showSearchBar)
                const CustomHeaderWithSearch()
              else
                CustomHeader(title: headerTitle, showLogo: showLogo),
              Expanded(child: mainPageContent),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return CustomBottomNavigationBar(
            selectedIndex: state is NavigationSelectedState ? state.selectedIndex : 0,
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
  final String title;
  final bool showLogo;

  const CustomHeader({
    super.key,
    required this.title,
    this.showLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          if (showLogo)
            SvgPicture.asset(
              "ressources/Logo.svg", 
              width: 85,
              height: 110,
            ),
        ],
      ),
    );
  }
}

class CustomHeaderWithSearch extends StatelessWidget {
  const CustomHeaderWithSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomHeader(title: 'Recherche'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Comic, film, série...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



