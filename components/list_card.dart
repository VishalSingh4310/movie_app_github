import 'package:flutter/material.dart';
import 'package:movies_app/components/generic_list_card.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/pages/details.dart';
import 'package:movies_app/utils/constants.dart';

class ListCard extends StatefulWidget {
  final Movie movieItems;
  final String fromNav;
  const ListCard({
    super.key,
    required this.movieItems,
    required this.fromNav,
  });

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  late void Function() handler;
  @override
  void initState() {
    super.initState();
    handler = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(
            movieId: widget.movieItems.id,
            fromNav: headingTopRatedMovies,
            key: Key(widget.movieItems.id.toString()),
          ),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return GenericListCard(
      id: widget.movieItems.id.toString() + headingTopRatedMovies,
      imageUrl: widget.movieItems.posterPath,
      title: widget.movieItems.title,
      onPressed: handler,
    );
  }
}
