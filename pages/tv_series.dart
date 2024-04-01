import 'package:flutter/material.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/organism/popular_tv_series.dart';
import 'package:movies_app/organism/top_rated_series.dart';
import 'package:movies_app/services/tv.dart';
import 'package:movies_app/utils/constants.dart';

class TVSeriesPage extends StatefulWidget {
  const TVSeriesPage({super.key});

  @override
  State<TVSeriesPage> createState() => _TVSeriesPageState();
}

class _TVSeriesPageState extends State<TVSeriesPage> {
  TVShow? topRatedSeries;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getTopMovies();
  }

  getTopMovies() async {
    topRatedSeries = await RemoteTvService().getTopRatedSeries();

    if (topRatedSeries != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(title: headingTopRatedSeries),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: topRatedSeries != null
                ? SeriesSlider(
                    platform: Platforms.tvShow,
                    items: topRatedSeries!.results,
                    fromNav: headingTopRatedSeries,
                  )
                : Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Skeleton(height: size.height * 0.25),
                  ),
          ),
          const Heading(title: headingPopularSeries),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: PopularSeries(),
          ),
        ],
      ),
    );
  }
}
