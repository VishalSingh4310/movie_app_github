import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card_caption.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/pages/details.dart';
import 'package:movies_app/utils/constants.dart';

class GridCard extends StatelessWidget {
  final Movie movieItems;
  final String fromNav;
  const GridCard({
    super.key,
    required this.movieItems,
    required this.fromNav,
  });

  @override
  Widget build(BuildContext context) {
    onTapHandler() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(
            movieId: movieItems.id,
            fromNav: headingPopularMovies,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTapHandler,
      child: Column(
        children: [
          Hero(
            tag: '${movieItems.id}+$fromNav',
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  imageUrl: kImagePrefix500 + movieItems.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: MovieCardCaption(
              width: 100,
              isSubData: false,
              title: movieItems.title,
              releaseDate: movieItems.releaseDate,
              voteAverage: movieItems.voteAverage,
              genreIds: movieItems.genreIds,
            ),
          )
        ],
      ),
    );
  }
}
