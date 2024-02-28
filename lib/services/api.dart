import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchApi {
  Future<List> fetchData() async {
    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting'
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['result']);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
