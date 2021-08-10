import 'package:films/src/models/movies-model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> list;

  CardSwiperWidget({required this.list});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 1.0),
      width: double.infinity,
      height: _screenSize.height * 0.6,
      child: Swiper(
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: list[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.png'),
                image: NetworkImage(list[index].getPoster()),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        itemCount: list.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl()
      ),
    );
  }
}
