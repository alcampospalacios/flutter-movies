import 'package:films/src/models/actors-model.dart';
import 'package:films/src/models/movies-model.dart';
import 'package:films/src/providers/movies-provider.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie? _movie = ModalRoute.of(context)!.settings.arguments as Movie?;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppBar(_movie),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          SizedBox(
            height: 5.0,
          ),
          _posterTitle(context, _movie),
          _description(_movie),
          _createCast(_movie)
        ]))
      ],
    ));
  }

  Widget _createAppBar(Movie? movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            movie!.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackdropPath()),
          placeholder: AssetImage('assets/no-image.png'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie? movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie!.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPoster()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star_border,
                    color: Colors.amber[600],
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('${movie.voteAverage}/${movie.voteCount}',
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(Movie? movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie!.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCast(Movie? movie) {
    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie!.id.toString()),
      builder: (context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(context, snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createActorsPageView(BuildContext context, List<Actor>? actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          itemCount: actors!.length,
          itemBuilder: (context, index) {
            return Container(
              // margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.png'),
                      image: NetworkImage(actors[index].getProfileImage()),
                      fit: BoxFit.cover,
                      height: 140,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    actors[index].originalName,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
