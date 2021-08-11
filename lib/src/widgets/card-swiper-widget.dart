import 'package:films/src/models/movie.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> movies;

  CardSwiperWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    if (movies.length == 0) {
      return Container(
        height: _screenSize.height * 0.6,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 1.0),
      width: double.infinity,
      height: _screenSize.height * 0.6,
      child: Swiper(
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          movies[index].idHero =
              '${movies[index].title}-$index-${movies[index].id}';
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detail',
                arguments: movies[index]),
            child: Hero(
              tag: movies[index].idHero!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.png'),
                  image: NetworkImage(movies[index].getPoster()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl()
      ),
    );
  }
}
