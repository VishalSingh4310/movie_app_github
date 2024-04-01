import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card_caption.dart';
import 'package:movies_app/organism/tv_series_details.dart';
import 'package:movies_app/pages/details.dart';
import 'package:movies_app/utils/constants.dart';

class GenericGridCard extends StatelessWidget {
  final String id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final int? runtime;
  final double? voteAverage;
  final List<int>? genreIds;
  final String fromNav;
  const GenericGridCard({
    super.key,
    required this.fromNav,
    required this.title,
    required this.releaseDate,
    this.runtime,
    this.voteAverage,
    this.genreIds,
    required this.id,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    onTapHandler() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeriesDetails(
            id: int.parse(id),
            platform: Platforms.tvShow,
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
            tag: '$id+$fromNav',
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  imageUrl: kImagePrefix500 + posterPath,
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
              title: title,
              releaseDate: releaseDate,
              voteAverage: voteAverage,
              genreIds: genreIds,
            ),
          )
        ],
      ),
    );
  }
}
