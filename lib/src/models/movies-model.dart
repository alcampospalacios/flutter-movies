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
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
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

  // Widget getPoster() {
  //   if (posterPath == null) {
  //     return Image(image: AssetImage('assets/no-image.png'));
  //   } else {
  //     return FadeInImage(
  //         placeholder: AssetImage('assets/no-image.png'),
  //         image: NetworkImage(
  //           'https://image.tmdb.org/t/p/w500/$posterPath',
  //         ));

  //   }
  // }

  String getPoster() {
    if (posterPath == null) {
      return 'https://therockstore.com.ar/wp-content/uploads/2021/06/noImg-24.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }
}
