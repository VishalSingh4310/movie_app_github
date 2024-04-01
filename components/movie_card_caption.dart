import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/helper.dart';

class MovieCardCaption extends StatelessWidget {
  final double? width;
  final Color? titleColor;
  final Color? captionColor;
  final bool? isSubData;
  final String title;
  final String releaseDate;
  final int? runtime;
  final double? voteAverage;
  final List<int>? genreIds;
  const MovieCardCaption({
    super.key,
    this.titleColor,
    this.captionColor,
    this.isSubData,
    this.width,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    this.genreIds,
    this.runtime,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width ?? 200,
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: titleColor,
                        fontWeight: FontWeight.w800,
                      )),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width ?? size.width * 0.8,
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    // softWrap: false,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: captionColor ?? Colors.grey.shade900),
                      children: [
                        TextSpan(
                            text: "${getYearFromDate(releaseDate)} ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: captionColor,
                                )),
                        if (genreIds != null)
                          TextSpan(
                              text: getGenreNames(genreIds),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: captionColor,
                                  )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            isSubData == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(convertMinutesToHoursMinutes(runtime ?? 0),
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(
                        height: 5, // <-- SEE HERE
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.amber,
                            size: 18,
                          ),
                          if (voteAverage != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                voteAverage.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                        ],
                      )
                    ],
                  )
                : const SizedBox()
          ],
        )
      ],
    );
  }
}
