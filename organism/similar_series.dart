import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/components/generic_grid_card.dart';
import 'package:movies_app/components/grid_card.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/services/tv.dart';
import 'package:movies_app/utils/constants.dart';

class SimilarSeries extends StatefulWidget {
  final int id;
  const SimilarSeries({
    super.key,
    required this.id,
  });

  @override
  State<SimilarSeries> createState() => _SimilarSeriesState();
}

class _SimilarSeriesState extends State<SimilarSeries> {
  Future<String> fetchSimilarMovies() async {
    await getSimilarSeries();
    return "SimilarMovies loaded successfully.";
  }

  TVShow? similarSeries;

  getSimilarSeries() async {
    similarSeries =
        await RemoteTvService().getTvSeriesRecommendations(widget.id);
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
                return gridLoader(size);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return similarSeries != null
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
        similarSeries != null && similarSeries!.results.isNotEmpty
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
              children: similarSeries!.results.map((TVShowResult value) {
                return GenericGridCard(
                  id: value.id.toString(),
                  posterPath: value.posterPath,
                  releaseDate: value.firstAirDate,
                  title: value.name,
                  genreIds: value.genreIds,
                  fromNav: headingPopularMovies,
                );
              }).toList()),
        ),
      ],
    );
  }
}

Padding gridLoader(Size size) {
  return Padding(
    padding: const EdgeInsets.all(kDefaultPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(
          height: 15,
          width: size.width * 0.5,
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 230,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  height: size.height * 0.2,
                  // width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                Skeleton(
                  height: 8,
                  width: size.width * 0.2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Skeleton(
                  height: 8,
                  width: size.width * 0.35,
                ),
              ],
            );
          },
        )
      ],
    ),
  );
}
