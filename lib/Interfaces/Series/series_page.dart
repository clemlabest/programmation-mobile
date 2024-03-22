import 'package:comics_application/Interfaces/Accueil/container_series.dart';
import 'package:flutter/material.dart';

class MySeriesPage extends StatefulWidget {
  const MySeriesPage({super.key});

  @override
  _MySeriesPageState createState() => _MySeriesPageState();
}

class _MySeriesPageState extends State<MySeriesPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF15232E),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            SeriesSectionHeader(),
          ],
        ),
      ),
    );
  }
}
