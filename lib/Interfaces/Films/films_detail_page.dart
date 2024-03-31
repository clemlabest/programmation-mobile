import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../API/api.dart';

class MoviesDetailPage extends StatefulWidget {
  final String moviesId;

  const MoviesDetailPage({super.key, required this.moviesId});

  @override
  MoviesDetailPageState createState() => MoviesDetailPageState();
}

class MoviesDetailPageState extends State<MoviesDetailPage> {
  late final ComicVineAPI apiClient;
  Map<String, dynamic>? moviesDetails;
  Map<String, dynamic>? foundFilm;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef');
    fetchMoviesDetails();
  }

  Future<void> fetchMoviesDetails() async {
    try {
      final data = await apiClient.getEndpointData('movies/${widget.moviesId}');
if (!mounted) return;
for (var film in data['results']) {
  if (film['id'].toString() == widget.moviesId) {
    foundFilm = film;
    break;
  }
}
setState(() {
  moviesDetails = foundFilm;
  isLoading = false;
});
    } catch (e) {
      print(e.toString());
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
    final title = moviesDetails?['name'] as String? ?? 'Chargement...';
    final summary = moviesDetails?['deck'] as String? ?? 'Résumé non disponible.';

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
    final imageUrl = moviesDetails?['image']?['original_url'] as String? ?? 'https://placekitten.com/200/300';
    final runtime = moviesDetails?['runtime']?.toString() ?? 'Durée non disponible';
    final startYear = moviesDetails?['release_date']?.toString() ?? 'Inconnue';

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
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_tv_bicolor.svg", '$runtime mn'),
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
