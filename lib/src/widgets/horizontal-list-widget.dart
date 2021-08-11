import 'package:films/src/models/movie.dart';
import 'package:flutter/material.dart';

class HorizontalListWidget extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  HorizontalListWidget(
      {required this.movies, this.title, required this.onNextPage});

  @override
  _HorizontalListWidgetState createState() => _HorizontalListWidgetState();
}

class _HorizontalListWidgetState extends State<HorizontalListWidget> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) widget.onNextPage();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    if (widget.movies.length == 0) {
      return Container(
        height: _screenSize.height * 0.3,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      // height: _screenSize.height * 0.4,
      height: 260,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.title != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  this.widget.title!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  itemCount: widget.movies.length,
                  itemBuilder: (context, index) =>
                      _MoviePoster(this.widget.movies[index])),
            ),
          ]),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.idHero = 'swiper-${movie.id}';

    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'detail', arguments: movie);
            },
            child: Hero(
              tag: movie.idHero!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.png'),
                  image: NetworkImage(movie.getPoster()),
                  fit: BoxFit.cover,
                  width: 130,
                  height: 190,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

// Widget _createCard(BuildContext context, Movie movie) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.pushNamed(context, 'detail', arguments: movie);
//     },
//     child: Container(
//       margin: EdgeInsets.only(right: 15.0),
//       child: Column(
//         children: [
//           Hero(
//             tag: movie.id,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: FadeInImage(
//                 placeholder: AssetImage('assets/no-image.png'),
//                 image: NetworkImage(movie.getPoster()),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           Text(
//             movie.title,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.caption,
//           )
//         ],
//       ),
//     ),
//   );
// }
