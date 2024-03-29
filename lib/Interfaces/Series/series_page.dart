import 'package:flutter/material.dart';
import '../../API/api.dart'; // Assurez-vous que cet import pointe vers votre fichier api.dart

class MySeriesPage extends StatefulWidget {
  const MySeriesPage({super.key});

  @override
  _MySeriesPageState createState() => _MySeriesPageState();
}

class _MySeriesPageState extends State<MySeriesPage> {
  late final ComicVineAPI apiClient;
  List<dynamic> seriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef'); // Remplacez 'votre_clé_api' par votre clé API réelle
    fetchSeries();
  }

  Future<void> fetchSeries() async {
    try {
      final data = await apiClient.getEndpointData('series_list'); // Assurez-vous que 'series_list' est le bon endpoint
      if (!mounted) return;
      setState(() {
        seriesList = data['results'];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: seriesList.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.transparent, height: 20),
              itemBuilder: (context, index) {
                final series = seriesList[index];
                final imageInfo = series['image'] ?? {};
                final thumbnailUrl = imageInfo['small_url'] ?? 'https://placekitten.com/200/300';
                
                return Card(
                  color: const Color(0xFF1E3243),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  thumbnailUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 227, 139, 9),
                                  borderRadius: BorderRadius.circular(20), // Plus arrondi pour un ovale
                                ),
                                child: Text(
                                  '#${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                series['name'] ?? 'Titre inconnu',
                                style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Année : ${series['start_year'] ?? 'Inconnue'}',
                                style: const TextStyle(fontSize: 15, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
