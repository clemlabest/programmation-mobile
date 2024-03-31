import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../API/api.dart';

class ComicsDetailPage extends StatefulWidget {
  final String comicsId;

  const ComicsDetailPage({super.key, required this.comicsId});

  @override
  ComicsDetailPageState createState() => ComicsDetailPageState();
}

class ComicsDetailPageState extends State<ComicsDetailPage> {
  late final ComicVineAPI apiClient;
  Map<String, dynamic>? comicsDetails;
  Map<String, dynamic>? foundComics;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ComicVineAPI(apiKey: '91901ce3797af349853aa79db4730e1aded30eef');
    fetchComicsDetails();
  }

  Future<void> fetchComicsDetails() async {
    try {
      final data = await apiClient.getEndpointData('issues/${widget.comicsId}');
      if (!mounted) return;
      for (var comics in data['results']) {
  if (comics['id'].toString() == widget.comicsId) {
    foundComics = comics;
    break;
  }
}
      setState(() {
        comicsDetails = foundComics;
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
    final title = comicsDetails?['name'] as String? ?? 'Chargement...';
    final summary = comicsDetails?['description'] as String? ?? 'Résumé non disponible.';

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
    final imageUrl = comicsDetails?['image']?['original_url'] as String? ?? 'https://placekitten.com/200/300';
    final startYear = comicsDetails?['store_date']?.toString() ?? 'Inconnue';
    final number = comicsDetails?['issue_number']?.toString() ?? '?';

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
                      buildDetailItem(context, "ressources/BottomNavigationBar/ic_books_bicolor.svg", number),
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
                  },
                  child: const Text('Histoire', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                  },
                  child: const Text('Auteurs', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                  },
                  child: const Text('Personnages', style: TextStyle(color: Colors.white, fontSize: 18)),
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
