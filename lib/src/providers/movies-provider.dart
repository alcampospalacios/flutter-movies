import 'dart:async';
import 'package:films/src/helpers/debouncer.dart';
import 'package:films/src/models/credits_response.dart';
import 'package:films/src/models/movie.dart';
import 'package:films/src/models/now_playing_response.dart';
import 'package:films/src/models/popular_response.dart';
import 'package:films/src/models/search_response.dart';
import 'package:films/src/models/up_coming_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  // // request data
  String _apiKey = 'f222162fa537c6b651ecfc1f02a53e2d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _page = 0;

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopular = [];
  List<Movie> onDisplayUpComing = [];

  Map<int, List<Cast>> cast = {};
  Map<String, List<Movie>> _searchResults = {};

  // Stream to implement search debouncer
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamControler =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamControler.stream;

  void getSuggestionByQuery(String query) {
    debouncer.value = '';

    debouncer.onValue = (value) async {
      if (this._searchResults.containsKey(value)) {
        this._suggestionStreamControler.add(this._searchResults[value]!);
      } else {
        final results = await this.searchMovie(value);
        this._suggestionStreamControler.add(results);
        this._searchResults[value] = results;
      }
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  // ****************************************************************************************************

  MoviesProvider() {
    this.getMoviesNowPlaying();
    this.getPopular();
    this.getUpComing();
  }

  Future<String> _request(String endpoint, [int page = 1]) async {
    final url = Uri.https(_url, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // awaiting by the http response
    final response = await http.get(url);
    return response.body;
  }

  getMoviesNowPlaying() async {
    final response = await this._request('3/movie/now_playing');
    final nowPlayingRes = NowPlayingResponse.fromJson(response);

    this.onDisplayMovies = nowPlayingRes.results;
    notifyListeners();
  }

  getPopular() async {
    this._page++;

    final response = await this._request('3/movie/popular', this._page);
    final popularResponse = PopularResponse.fromJson(response);

    this.onDisplayPopular = [
      ...this.onDisplayPopular,
      ...popularResponse.results
    ];
    notifyListeners();
  }

  getUpComing() async {
    this._page++;

    final response = await this._request('3/movie/upcoming', this._page);
    final upComingResponse = UpComingResponse.fromJson(response);

    this.onDisplayUpComing = [
      ...this.onDisplayUpComing,
      ...upComingResponse.results
    ];
    notifyListeners();
  }

  Future<List<Cast>> getCast(int idMovie) async {
    if (this.cast.containsKey(idMovie)) return this.cast[idMovie]!;

    final response = await this._request('3/movie/$idMovie/credits');
    final crediResponse = CreditResponse.fromJson(response);

    this.cast[idMovie] = crediResponse.cast;
    return crediResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }
}
