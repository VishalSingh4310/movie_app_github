import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card_caption.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/organism/tv_series_details.dart';
import 'package:movies_app/pages/details.dart';
import 'package:movies_app/utils/constants.dart';

class SeriesSlider extends StatelessWidget {
  final List<TVShowResult> items;
  final Platforms platform;
  final String fromNav;
  const SeriesSlider(
      {super.key,
      required this.items,
      required this.fromNav,
      required this.platform});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: _sliderItems(items, context, fromNav, platform),
    );
  }
}

List<Widget> _sliderItems(
    List<TVShowResult> imageSliders, context, fromNav, Platforms platform) {
  bool isMovie = platform == Platforms.movie;
  onTapHandler(item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => isMovie
            ? MovieDetails(
                movieId: item.id,
                fromNav: headingUpcomingMovies,
              )
            : SeriesDetails(
                id: item.id,
                fromNav: headingUpcomingMovies,
                platform: platform,
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
                      tag: '${item.id}+$fromNav',
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
                            title: item.name,
                            releaseDate: item!.firstAirDate,
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
