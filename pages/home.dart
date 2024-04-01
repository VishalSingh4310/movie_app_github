import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/icon_button.dart';
import 'package:movies_app/components/search_bar.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/components/slider_list.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/organism/popular_movies.dart';
import 'package:movies_app/organism/top_rated_movies.dart';
import 'package:movies_app/services/movies.dart';
import 'package:movies_app/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MovieList? upcomingMovies;
  var isUpcomingMoviesLoaded = false;

  @override
  void initState() {
    super.initState();
    getTopMovies();
  }

  getTopMovies() async {
    upcomingMovies = await RemoteService().getUpcomingMovies();

    if (upcomingMovies != null) {
      setState(() {
        isUpcomingMoviesLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: isUpcomingMoviesLoaded
          ? SingleChildScrollView(
              physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(kDefaultPadding),
                          bottomRight: Radius.circular(kDefaultPadding)),
                    ),
                    child: Stack(clipBehavior: Clip.none, children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: kDefaultPadding,
                              right: kDefaultPadding,
                              top: 10,
                              bottom: 0,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          CupertinoIcons.film,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Text(
                                        headingMovies,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                    ],
                                  ),
                                  const CustomIconButtom(
                                    icon: CupertinoIcons.bell_fill,
                                    iconColor: Colors.white,
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 2 * kDefaultPadding,
                          )
                        ],
                      ),
                      Positioned(
                        bottom: -20,
                        child: SizedBox(
                          width: size.width,
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: kDefaultPadding,
                              right: kDefaultPadding,
                              top: kDefaultPadding,
                            ),
                            child: SearchBarComp(),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  const Heading(title: headingUpcomingMovies),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: upcomingMovies != null
                        ? MainSlider(
                            items: upcomingMovies!.results,
                            fromNav: headingUpcomingMovies,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Skeleton(height: size.height * 0.25),
                          ),
                  ),
                  const TopRatedMovies(),
                  const PopularMovies()
                  // const PopularMovies()
                ],
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }
}
