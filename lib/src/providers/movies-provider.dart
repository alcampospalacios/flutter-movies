import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:films/src/models/movies-model.dart';

class MoviesProvider {
  String _apiKey = 'f222162fa537c6b651ecfc1f02a53e2d';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _languaje, 'page': '1'});

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData['results']);
    return movies.listOfMovies;
  }
}
