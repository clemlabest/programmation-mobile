import 'dart:convert';
import 'package:http/http.dart' as http;

class ComicVineAPI {
  final String apiKey;
  final String baseUrl = 'https://comicvine.gamespot.com/api';

  ComicVineAPI({required this.apiKey});

  Future<Map<String, dynamic>> getEndpointData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint?api_key=$apiKey&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from ComicVine API');
    }
  }
}

