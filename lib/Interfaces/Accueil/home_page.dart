import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comics_application/BloC/navigation_bloc.dart';
import 'package:comics_application/BloC/navigation_event.dart';
import 'package:comics_application/BloC/navigation_state.dart';
import 'package:comics_application/Interfaces/Accueil/appbar.dart';
import 'package:comics_application/Interfaces/Comics/appbar1.dart';
import 'package:comics_application/Interfaces/Series/appbar2.dart';
import 'package:comics_application/Interfaces/Films/appbar3.dart';
import 'package:comics_application/Interfaces/Recherche/appbar4.dart';
import 'package:comics_application/Interfaces/bottom_navigation_bar.dart';
import 'package:comics_application/Interfaces/Comics/comics_page.dart';
import 'package:comics_application/Interfaces/Series/series_page.dart';
import 'package:comics_application/Interfaces/Films/films_page.dart';
import 'package:comics_application/Interfaces/Recherche/recherche_page.dart';
import 'package:comics_application/Interfaces/Accueil/container_comics.dart';
import 'package:comics_application/Interfaces/Accueil/container_series.dart';
import 'package:comics_application/Interfaces/Accueil/container_films.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationSelectedState) {
              switch (state.selectedIndex) {
                case 1:
                  return const CustomAppBar1();
                case 2:
                  return const CustomAppBar2();
                case 3:
                  return const CustomAppBar3();
                case 4:
                  return const CustomAppBar4();
                default:
                  return const CustomAppBar();
              }
            }
            return const CustomAppBar();
          },
        ),
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationSelectedState) {
            switch (state.selectedIndex) {
              case 1:
                return const MyComicsPage();
              case 2:
                return const MySeriesPage();
              case 3:
                return const MyFilmsPage();
              case 4:
                return const MySearchPage();
              default:
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
          }
          return const SingleChildScrollView(
            child: Column(
              children: [
                SeriesSectionHeader(),
                ComicsSectionHeader(),
                FilmsSectionHeader(),
              ],
            ),
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
