import 'dart:async';
import 'dart:convert';
import 'package:films/src/models/actors-model.dart';
import 'package:http/http.dart' as http;

import 'package:films/src/models/movies-model.dart';

class MoviesProvider {
  // request data
  String _apiKey = 'f222162fa537c6b651ecfc1f02a53e2d';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _page = 0;

  bool _loading = false;

  // handling the list
  List<Movie> _popular = [];

  // Dlecaring stream controller, something like observables
  final _streamController = StreamController<List<Movie>>.broadcast();

  // getters and setters stream controller
  Function(List<Movie>) get controllerSink => _streamController.sink.add;
  Stream<List<Movie>> get controllerStream => _streamController.stream;

  // destroying the stream controllers
  void disposeStream() {
    _streamController.close();
  }

  Future<List<Movie>> _request(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData['results']);
    return movies.listOfMovies;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _languaje, 'page': '1'});

    return await _request(url);
  }

  Future<List<Movie>> getPopularMovie() async {
    if (_loading) return [];
    _loading = true;

    _page++;
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _languaje, 'page': _page.toString()});

    final response = await _request(url);
    _popular.addAll(response);

    controllerSink(_popular);

    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String idMovie) async {
    final url = Uri.https(_url, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _languaje});

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final actors = new Actors.fromJsonList(decodeData['cast']);
    return actors.listOfActors;
  }
}
