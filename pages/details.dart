import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/hero_card.dart';
import 'package:movies_app/components/loaders/list_loader.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/models/movie_credits.dart';
import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/organism/similar_movies.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/utils/constants.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  final String fromNav;
  final Platforms? platform;
  const MovieDetails(
      {super.key, required this.fromNav, required this.movieId, this.platform});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  MovieDetailed? movieDetails1;
  MovieInfo? movieCreditsDetails;
  Future<String> fetchPopularMovies() async {
    await getMovieDetails();
    return "Movie loaded successfully.";
  }

  Future<String> fetchMovieCredits() async {
    await getMovieCreditsDetails();
    return "Movie Credtis loaded successfully.";
  }

  getMovieDetails() async {
    movieDetails1 = await RemoteService().getMovieDetails(widget.movieId);
  }

  getMovieCreditsDetails() async {
    movieCreditsDetails =
        await RemoteService().getMovieCreditsDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: fetchPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loader(size);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return movieData(context);
                  }
                },
              ),
              FutureBuilder(
                future: fetchMovieCredits(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListLoader();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return topBilledCast(size);
                  }
                },
                // child:,
              ),
              SimilarMovies(
                movieId: widget.movieId,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column topBilledCast(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(
          title: "Top Billed Cast",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics:
                    const PageScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: movieCreditsDetails!.cast.length > 10
                    ? 10
                    : movieCreditsDetails!.cast.length,
                itemExtent: size.width * 0.3,
                itemBuilder: (context, index) {
                  String? imageUrl =
                      movieCreditsDetails!.cast[index].profilePath;
                  return Column(
                    children: [
                      imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                height: 150,
                                // width: 200,
                                (kImagePrefix500 + imageUrl),
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.topCenter,
                              ),
                            )
                          : const Skeleton(
                              height: 150,
                              width: 110,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      cards(
                          context,
                          movieCreditsDetails!.cast[index].originalName ?? '',
                          movieCreditsDetails!.cast[index].character ?? ''),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  Column movieData(BuildContext context) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    String formattedBudget = formatter.format(movieDetails1!.budget);
    String formattedRevenue = formatter.format(movieDetails1!.revenue);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroCard(
          id: movieDetails1!.id.toString(),
          trailerLinks: movieDetails1!.videos!.results,
          fromNav: widget.fromNav,
          posterPath: movieDetails1!.posterPath,
          releaseDate: movieDetails1!.releaseDate,
          title: movieDetails1!.title,
          voteAverage: movieDetails1!.voteAverage,
          runtime: movieDetails1!.runtime,
        ),
        const Heading(title: "Overview"),
        Padding(
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: 10,
          ),
          child: Text(
            movieDetails1!.tagline,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic, color: Colors.amber.shade800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            movieDetails1!.overview,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: 10.0),
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 4.2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                cards(context, 'Status', movieDetails1!.status),
                if (movieDetails1!.budget > 0)
                  cards(context, 'Budget', '\$$formattedBudget'),
                if (movieDetails1!.revenue > 0)
                  cards(context, 'Revenue', '\$$formattedRevenue'),
              ]),
        ),
      ],
    );
  }

  Column cards(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(value,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

Padding loader(Size size) {
  return Padding(
    padding: const EdgeInsets.all(kDefaultPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(
          height: size.height * 0.4,
        ),
        const SizedBox(
          height: 20,
        ),
        Skeleton(
          height: 15,
          width: size.width * 0.5,
        ),
        const SizedBox(
          height: 20,
        ),
        Skeleton(
          height: 15,
          width: size.width,
        ),
      ],
    ),
  );
}
