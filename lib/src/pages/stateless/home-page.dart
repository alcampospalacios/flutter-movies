import 'package:films/src/pages/shared/search/search_delegate.dart';
import 'package:films/src/providers/movies-provider.dart';
import 'package:films/src/widgets/card-swiper-widget.dart';
import 'package:films/src/widgets/horizontal-list-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: MoviesSearchDelegate()),
              icon: Icon(Icons.search))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CardSwiperWidget(movies: moviesProvider.onDisplayMovies),
            SizedBox(
              height: 5.0,
            ),
            HorizontalListWidget(
              movies: moviesProvider.onDisplayPopular,
              title: 'Populares',
              onNextPage: moviesProvider.getPopular,
            ),
            SizedBox(
              height: 5.0,
            ),
            HorizontalListWidget(
              movies: moviesProvider.onDisplayUpComing,
              title: 'Varias',
              onNextPage: moviesProvider.getUpComing,
            )
          ],
        ),
      ),
    );
  }
}
