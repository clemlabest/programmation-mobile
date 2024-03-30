import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../API/api.dart';

class SeriesDetailPage extends StatefulWidget {
  final String seriesId;

  const SeriesDetailPage({super.key, required this.seriesId});

  @override
  SeriesDetailPageState createState() => SeriesDetailPageState();
}

class SeriesDetailPageState extends State<SeriesDetailPage> {
  late final ComicVineAPI apiClient;
  Map<String, dynamic>? seriesDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef');
    fetchSeriesDetails();
  }

  Future<void> fetchSeriesDetails() async {
    try {
      final data = await apiClient.getEndpointData('series/${widget.seriesId}');
      if (!mounted) return;
      setState(() {
        seriesDetails = data['results'];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildSvgIcon(String assetName) {
    return SvgPicture.asset(
      assetName,
      width: 20,
      height: 20,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn,),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = seriesDetails?['name'] as String? ?? 'Chargement...';
    final summary = seriesDetails?['deck'] as String? ?? 'Résumé non disponible.';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLoading ? 'Chargement...' : title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF15232E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : buildContent(context, summary),
    );
  }

  Widget buildContent(BuildContext context, String summary) {
    final imageUrl = seriesDetails?['image']?['original_url'] as String? ?? 'https://placekitten.com/200/300';
    final publisher = seriesDetails?['publisher']?['name'] as String? ?? 'Inconnu';
    final countOfEpisodes = seriesDetails?['count_of_episodes']?.toString() ?? '0';
    final startYear = seriesDetails?['start_year']?.toString() ?? 'Inconnue';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xFF15232E),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_publisher_bicolor.svg", publisher),
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_tv_bicolor.svg", '$countOfEpisodes épisodes'),
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_calendar_bicolor.svg", startYear),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF15232E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Logic for displaying the story goes here
                  },
                  child: const Text('Histoire', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    // Logic for displaying characters goes here
                  },
                  child: const Text('Personnages', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    // Logic for displaying episodes goes here
                  },
                  child: const Text('Épisodes', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              summary,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailItem(BuildContext context, String iconPath, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          _buildSvgIcon(iconPath),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16, color: Colors.white))),
        ],
      ),
    );
  }
}
