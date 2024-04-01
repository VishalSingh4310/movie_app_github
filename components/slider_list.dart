import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card_caption.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/pages/details.dart';
import 'package:movies_app/utils/constants.dart';

class MainSlider extends StatelessWidget {
  final List<Movie> items;
  final String fromNav;
  const MainSlider({super.key, required this.items, required this.fromNav});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: _sliderItems(items, context, fromNav),
    );
  }
}

List<Widget> _sliderItems(List<Movie> imageSliders, context, fromNav) {
  onTapHandler(item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetails(
          movieId: item.id,
          fromNav: headingUpcomingMovies,
        ),
      ),
    );
  }

  return imageSliders
      .map((item) => GestureDetector(
            onTap: () {
              onTapHandler(item);
            },
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: '${item.posterPath}+$fromNav',
                      child: Image.network(
                        kImagePrefix500 + item.posterPath,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: SizedBox(
                          child: MovieCardCaption(
                            width: 250,
                            isSubData: false,
                            titleColor: Colors.white,
                            captionColor: Colors.grey,
                            title: item.title,
                            releaseDate: item.releaseDate,
                            voteAverage: item.voteAverage,
                            genreIds: item.genreIds,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();
}
