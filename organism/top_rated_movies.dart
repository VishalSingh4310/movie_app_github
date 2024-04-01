import 'package:flutter/material.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/list_card.dart';
import 'package:movies_app/components/loaders/list_loader.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/utils/constants.dart';

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({
    super.key,
  });

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  Future<String> fetchData() async {
    await getTopMovies();
    return 'Data loaded successfully';
  }

  MovieList? topMovies;

  getTopMovies() async {
    topMovies = await RemoteService().getTopMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListLoader();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return list();
        }
      },
    );
  }

  Visibility list() {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      visible: topMovies != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(title: headingTopRatedMovies),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: SizedBox(
              height: size.height * 0.22,
              child: ListView.builder(
                itemExtent: size.width * 0.35,
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ListCard(
                    movieItems: topMovies!.results[index],
                    fromNav: headingTopRatedMovies,
                  );
                },
                itemCount: topMovies?.results.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
