import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/components/tap_wrapper.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/pages/details.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/utils/helper.dart';

class SearchList extends StatefulWidget {
  final String? searchValue;
  const SearchList({super.key, required this.searchValue});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Future<String> fetchSearchMovies() async {
    await getSearchMovies();
    return "SimilarMovies loaded successfully.";
  }

  MovieList? searchMovies;

  getSearchMovies() async {
    if (widget.searchValue!.isNotEmpty) {
      searchMovies = await RemoteService().searchMovies(widget.searchValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    log("searchValue in search ${widget.searchValue}");
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        FutureBuilder(
            future: fetchSearchMovies(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return listLoader(size);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return searchMovies != null &&
                        searchMovies!.results.isNotEmpty &&
                        widget.searchValue != null
                    ? SizedBox(
                        width: size.width - 2 * kDefaultPadding,
                        height: size.height * 0.7,
                        child: ListView.builder(
                            physics: const ScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: searchMovies!.results.length,
                            itemExtent: 70,
                            itemBuilder: (context, index) {
                              return searchListCard(
                                  context, size, searchMovies!.results[index]);
                              // return listLoader(size);
                            }),
                      )
                    : SizedBox(
                        height: size.height * 0.6,
                        child: const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.layers,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  textAlign: TextAlign.center,
                                  'Sorry, No Matches.\nTry a Different Search')
                            ],
                          ),
                        ),
                      );
              }
            }),
      ],
    );
  }

  OnTapScaleAndFade searchListCard(
      BuildContext context, Size size, Movie movie) {
    handler() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(
            movieId: movie.id,
            fromNav: headingTopRatedMovies,
            key: Key(movie.id.toString()),
          ),
        ),
      );
    }

    return OnTapScaleAndFade(
      key: Key(movie.id.toString()),
      onTap: () => handler(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: movie.posterPath.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: Hero(
                      tag: movie.id,
                      child: Image.network(
                        height: 60,
                        width: 60,
                        kImagePrefix500 + movie.posterPath,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  )
                : Stack(children: [
                    const Skeleton(
                      height: 60,
                      width: 60,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    )
                  ]),
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          // color: titleColor,
                          fontWeight: FontWeight.w600,
                        )),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  // softWrap: false,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        // color: captionColor ?? Colors.grey.shade900
                        ),
                    children: [
                      TextSpan(
                          text: "${getYearFromDate(movie.releaseDate)} ",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                  // color: captionColor,
                                  )),
                      TextSpan(
                          text: getGenreNames(movie.genreIds),
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                  // color: captionColor,
                                  )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Padding listLoader(Size size) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: SizedBox(
      width: size.width - 2 * kDefaultPadding,
      height: size.height * 0.7,
      child: ListView.builder(
        itemCount: 5,
        itemExtent: 70,
        itemBuilder: (context, index) {
          return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      height: 60,
                      width: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(
                            height: 8,
                            width: 100,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Skeleton(
                            height: 8,
                            width: 50,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]);
        },
      ),
    ),
  );
}
