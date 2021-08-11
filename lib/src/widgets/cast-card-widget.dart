import 'package:films/src/models/credits_response.dart';
import 'package:films/src/providers/movies-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastWidget extends StatelessWidget {
  final int idMovie;

  const CastWidget({Key? key, required this.idMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getCast(idMovie),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 180.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(top: 50),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(cast[index])),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.png'),
              image: NetworkImage(actor.getProfileImg()),
              fit: BoxFit.fill,
              height: 140,
              width: 100,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            actor.originalName,
            style: Theme.of(context).textTheme.subtitle1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
