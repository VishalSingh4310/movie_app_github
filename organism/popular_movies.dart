import 'package:flutter/material.dart';
import 'package:movies_app/components/grid_card.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/loaders/grid_loader.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/utils/constants.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({
    super.key,
  });

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  Future<String> fetchPopularMovies() async {
    await getPopularMovies();
    return "PopularMovies loaded successfully.";
  }

  MovieList? popularMovies;

  getPopularMovies() async {
    popularMovies = await RemoteService().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPopularMovies(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const GridLoader();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading(title: headingPopularMovies),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: gridViewCount(),
                ),
              ],
            );
          }
        });
  }

  GridView gridViewBuilder() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 330,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: popularMovies!.results.length,
      itemBuilder: (context, index) {
        return GridCard(
          movieItems: popularMovies!.results[index],
          fromNav: headingPopularMovies,
        );
      },
    );
  }

  GridView gridViewCount() {
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.73,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: popularMovies!.results.map((Movie value) {
          return GridCard(
            key: Key("${value.title}xd"),
            movieItems: value,
            fromNav: headingPopularMovies,
          );
        }).toList());
  }
}
