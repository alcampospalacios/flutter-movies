import 'package:flutter/material.dart';

class Movies {
  List<Movie> listOfMovies = [];

  Movies();

  Movies.fromJsonList(List<dynamic> listOfList) {
    if (listOfList == null) return;

    listOfList.forEach((element) {
      final movie = Movie.fromJsonMap(element);
      listOfMovies.add(movie);
    });
  }
}

class Movie {
  late bool adult;
  late String backdropPath;
  late List<int> genreIds;
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  String getPoster() {
    if (posterPath == null) {
      return 'https://therockstore.com.ar/wp-content/uploads/2021/06/noImg-24.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  String getBackdropPath() {
    if (backdropPath == null) {
      return 'https://therockstore.com.ar/wp-content/uploads/2021/06/noImg-24.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
