import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/components/grid_card.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/loaders/grid_loader.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/utils/constants.dart';

class SimilarMovies extends StatefulWidget {
  final int movieId;
  const SimilarMovies({
    super.key,
    required this.movieId,
  });

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  Future<String> fetchSimilarMovies() async {
    await getSimilarMovies();
    return "SimilarMovies loaded successfully.";
  }

  MovieList? similarMovies;

  getSimilarMovies() async {
    similarMovies = await RemoteService().getSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
            future: fetchSimilarMovies(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const GridLoader();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return similarMovies != null
                    ? gridViewCount()
                    : const SizedBox();
              }
            }),
      ],
    );
  }

  Column gridViewCount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        similarMovies != null && similarMovies!.results.isNotEmpty
            ? const Heading(
                title: "Recommendations",
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 0.73,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: similarMovies!.results.map((Movie value) {
                return GridCard(
                  key: Key("${value.title}xd"),
                  movieItems: value,
                  fromNav: headingPopularMovies,
                );
              }).toList()),
        ),
      ],
    );
  }
}
