import 'package:films/src/models/movie.dart';
import 'package:films/src/providers/movies-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        child: Center(
          child: Icon(
            Icons.movie_creation,
            size: 130,
            color: Colors.black38,
          ),
        ),
      );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: Icon(
                Icons.movie_creation,
                size: 130,
                color: Colors.black38,
              ),
            ),
          );
        }
        final List<Movie> listOfMovie = snapshot.data!;
        return ListView.builder(
            itemCount: listOfMovie.length,
            itemBuilder: (_, index) => _Movie(listOfMovie[index]));
      },
    );
  }
}

class _Movie extends StatelessWidget {
  final Movie movie;
  const _Movie(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.idHero = 'search-${movie.id}';
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Hero(
          tag: movie.idHero!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.png'),
              image: NetworkImage(movie.getPoster()),
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          movie.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onTap: () => Navigator.pushNamed(context, 'detail', arguments: movie),
      ),
    );
  }
}
