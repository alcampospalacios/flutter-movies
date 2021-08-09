import 'package:films/src/providers/movies-provider.dart';
import 'package:films/src/widgets/card-swiper-widget.dart';
import 'package:films/src/widgets/horizontal-list-widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final _moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopularMovie();

    return Scaffold(
      appBar: AppBar(
        title: Text('Films'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              _swipeCard(),
              SizedBox(
                height: 25.0,
              ),
              _footer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _swipeCard() {
    return FutureBuilder(
      future: _moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(
            list: snapshot.data,
          );
        } else {
          return Container(
            height: 300.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: _moviesProvider.controllerStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HorizontalListWidget(
                  listOfMovies: snapshot.data,
                  nextPage: _moviesProvider.getPopularMovie,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
