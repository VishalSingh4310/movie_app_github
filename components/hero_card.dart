import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card_caption.dart';
import 'package:movies_app/components/nav_header.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/utils/helper.dart';
import 'package:url_launcher/link.dart';

class HeroCard extends StatelessWidget {
  final String id;
  final String? posterPath;
  final String? title;
  final String releaseDate;
  final double voteAverage;
  final int? runtime;
  final List<Video>? trailerLinks;
  final String fromNav;
  const HeroCard({
    super.key,
    required this.fromNav,
    this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    this.runtime,
    this.trailerLinks,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    String imageUrl = posterPath != null
        ? (kImagePrefixOriginal + posterPath!)
        : "https://information-science-engineering.newhorizoncollegeofengineering.in/wp-content/uploads/2020/01/default_image_01.png";
    if (title != null) {
      return Stack(
        children: [
          Hero(
            tag: '$id+$fromNav',
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                imageUrl,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: kLinearGradientWhite,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: NavHeader(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // top: 200,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                gradient:
                    isDarkMode ? kLinearGradientBlack : kLinearGradientWhite,
              ),
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MovieCardCaption(
                    width: 250,
                    title: title ?? '',
                    releaseDate: releaseDate,
                    voteAverage: voteAverage,
                    genreIds: const [],
                    runtime: runtime,
                  ),
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Link(
                            uri: Uri.parse(
                                kYoutubeUrl(findTrailerLink(trailerLinks))),
                            builder: (context, go) {
                              return IconButton(
                                onPressed: go,
                                icon: Icon(
                                  CupertinoIcons.play_fill,
                                  color: Theme.of(context)
                                      .floatingActionButtonTheme
                                      .backgroundColor,
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: loader(size),
      );
    }
  }

  Column loader(Size size) {
    return Column(
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
    );
  }
}
