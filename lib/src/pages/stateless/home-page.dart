import 'package:films/src/providers/movies-provider.dart';
import 'package:films/src/widgets/card-swiper-widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final _moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Films'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_swipeCard()],
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
}
