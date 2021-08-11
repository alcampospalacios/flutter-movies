import 'package:films/src/models/movie.dart';
import 'package:films/src/widgets/cast-card-widget.dart';
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
            height: 10.0,
          ),
          _posterTitle(context, _movie),
          _description(_movie),
          CastWidget(idMovie: _movie!.id)
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
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: Text(
              movie!.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
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
            tag: movie!.idHero!,
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
                movie.originalTitle,
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Fecha de estreno: ${movie.releaseDate}',
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
                  Text('${movie.voteAverage}/10 de ${movie.voteCount}',
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
}
