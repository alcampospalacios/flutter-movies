import 'package:films/src/models/movies-model.dart';
import 'package:flutter/material.dart';

class HorizontalListWidget extends StatelessWidget {
  final List<Movie> listOfMovies;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function nextPage;

  HorizontalListWidget({required this.listOfMovies, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    // Listen by the final of the list to reload changes
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.4,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: listOfMovies.length,
        itemBuilder: (context, index) =>
            _createCard(context, listOfMovies[index]),
      ),
    );
  }

  Widget _createCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.png'),
                  image: NetworkImage(movie.getPoster()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
