import 'package:flutter/material.dart';
import 'package:movies_app/components/tap_wrapper.dart';
import 'package:movies_app/utils/constants.dart';

class GenericListCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final dynamic onPressed;

  const GenericListCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      key: Key(id),
      onTap: onPressed ?? () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Hero(
                tag: id,
                child: Image.network(
                  height: 150,
                  width: 150,
                  kImagePrefix500 + imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 100,
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
