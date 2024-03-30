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
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = seriesDetails?['name'] as String? ?? 'Chargement...';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLoading ? 'Chargement...' : title,
          style: const TextStyle(color: Colors.white), // Titre en blanc
        ),
        backgroundColor: const Color(0xFF15232E),
        iconTheme: const IconThemeData(
          color: Colors.white, // Bouton retour en blanc
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
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
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_publisher_bicolor.svg", '', publisher),
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_tv_bicolor.svg", countOfEpisodes,' épisodes'),
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_calendar_bicolor.svg", '', startYear),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Rest of the UI goes here
        ],
      ),
    );
  }

  Widget buildDetailItem(BuildContext context, String iconPath, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          _buildSvgIcon(iconPath),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}
