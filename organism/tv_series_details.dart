import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/hero_card.dart';
import 'package:movies_app/components/loaders/list_loader.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/models/movie_credits.dart';
import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/models/tv_series_credit.dart';
import 'package:movies_app/models/tv_series_details.dart';
import 'package:movies_app/organism/similar_series.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/services/tv.dart';
import 'package:movies_app/utils/constants.dart';

class SeriesDetails extends StatefulWidget {
  final int id;
  final String fromNav;
  final Platforms platform;
  const SeriesDetails(
      {super.key,
      required this.fromNav,
      required this.platform,
      required this.id});

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  MovieDetailed? movieDetails1;
  MovieInfo? movieCreditsDetails;
  TVShowDetail? seriesDetails;
  CastList? seriesCreditDetails;

  Future<String> fetchDetails() async {
    if (widget.platform == Platforms.movie) {
      await getMovieDetails();
    } else if (widget.platform == Platforms.tvShow) {
      await getSeriesDetails();
    }
    return "Movie loaded successfully.";
  }

  Future<String> fetchCredits() async {
    if (widget.platform == Platforms.movie) {
      await getMovieCreditsDetails();
    } else if (widget.platform == Platforms.tvShow) {
      await getSeriesCreditsDetails();
    }
    return "Movie Credtis loaded successfully.";
  }

  getMovieDetails() async {
    movieDetails1 = await RemoteService().getMovieDetails(widget.id);
  }

  getSeriesDetails() async {
    seriesDetails = await RemoteTvService().getTvSeriesDetails(widget.id);
  }

  getMovieCreditsDetails() async {
    movieCreditsDetails =
        await RemoteService().getMovieCreditsDetails(widget.id);
  }

  getSeriesCreditsDetails() async {
    seriesCreditDetails = await RemoteTvService().getTvSeriesCredits(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isMovie = widget.platform == Platforms.movie ? true : false;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: fetchDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loader(size);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return movieData(context, isMovie,
                        isMovie ? movieDetails1 : seriesDetails);
                  }
                },
              ),
              FutureBuilder(
                future: fetchCredits(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListLoader();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return topBilledCast(size, isMovie,
                        isMovie ? movieCreditsDetails : seriesCreditDetails);
                  }
                },
                // child:,
              ),
              SimilarSeries(
                id: widget.id,
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

  Column topBilledCast(Size size, bool isMovie, data) {
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
                itemCount: data!.cast.length > 10 ? 10 : data!.cast.length,
                itemExtent: size.width * 0.3,
                itemBuilder: (context, index) {
                  String name = data!.cast[index].originalName;
                  String character = isMovie
                      ? data!.cast[index]!.character ?? ''
                      : data!.cast[index]!.roles![0]!.character ?? '';
                  String? imageUrl = data!.cast[index].profilePath;
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
                      cards(context, name, character),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  Column movieData(BuildContext context, bool isMovie, data) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    String formattedBudget = isMovie ? formatter.format(data!.budget) : "";
    String formattedRevenue = isMovie ? formatter.format(data!.revenue) : '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroCard(
          id: data!.id.toString(),
          trailerLinks: data!.videos!.results,
          fromNav: widget.fromNav,
          posterPath: data!.posterPath,
          releaseDate: isMovie ? data!.releaseDate : data!.lastAirDate,
          title: isMovie ? data!.title : data!.name,
          voteAverage: data!.voteAverage,
          runtime: isMovie ? data!.runtime : null,
        ),
        const Heading(title: "Overview"),
        Padding(
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: 10,
          ),
          child: Text(
            data!.tagline,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic, color: Colors.amber.shade800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            data!.overview,
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
                cards(context, 'Status', data!.status),
                if (isMovie && data.budget != null && data.budget > 0)
                  cards(context, 'Budget', '\$$formattedBudget'),
                if (isMovie && data.revenue != null && data.revenue > 0)
                  cards(context, 'Revenue', '\$$formattedRevenue'),
                if (!isMovie &&
                    data.networks != null &&
                    data.networks.isNotEmpty)
                  cards(context, 'Networks', data.networks[0]!.name ?? ''),
                if (!isMovie &&
                    data.productionCompanies != null &&
                    data.productionCompanies.isNotEmpty)
                  cards(context, 'Production',
                      data.productionCompanies[0]!.name ?? ''),
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

Padding listLoader(Size size) {
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
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: size.width * 0.3,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: size.height * 0.2,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Skeleton(
                    height: 8,
                    width: size.width * 0.1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Skeleton(
                    height: 8,
                    width: size.width * 0.2,
                  ),
                ],
              );
            },
            itemCount: 5,
          ),
        ),
      ],
    ),
  );
}
