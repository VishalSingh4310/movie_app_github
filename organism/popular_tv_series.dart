import 'package:flutter/material.dart';
import 'package:movies_app/components/generic_grid_card.dart';
import 'package:movies_app/components/loaders/grid_loader.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/services/tv.dart';
import 'package:movies_app/utils/constants.dart';

class PopularSeries extends StatefulWidget {
  const PopularSeries({
    super.key,
  });

  @override
  State<PopularSeries> createState() => _PopularSeriesState();
}

class _PopularSeriesState extends State<PopularSeries> {
  Future<String> fetchData() async {
    await getPopularSeries();
    return 'Data loaded successfully';
  }

  TVShow? popularSeries;

  getPopularSeries() async {
    popularSeries = await RemoteTvService().getPopularTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GridLoader();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return gridViewCount();
          // return list();
        }
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
        children: popularSeries!.results.map((TVShowResult value) {
          return GenericGridCard(
            id: value.id.toString(),
            posterPath: value.posterPath,
            releaseDate: value.firstAirDate,
            title: value.name,
            genreIds: value.genreIds,
            fromNav: headingPopularMovies,
          );
        }).toList());
  }

  // Visibility list() {
  //   Size size = MediaQuery.of(context).size;
  //   return Visibility(
  //     replacement: const Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //     visible: popularSeries != null,
  //     child: SizedBox(
  //       height: size.height * 0.25,
  //       child: ListView.builder(
  //         itemCount: popularSeries?.results.length,
  //         itemExtent: size.width * 0.35,
  //         physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           return GenericListCard(
  //               title: popularSeries?.results[index].name ?? '',
  //               imageUrl: popularSeries?.results[index].posterPath ?? "",
  //               id: popularSeries?.results[index].id.toString() ?? '');
  //         },
  //       ),
  //     ),
  //   );
  // }
}
