import 'package:flutter/material.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/utils/constants.dart';

class ListLoader extends StatelessWidget {
  const ListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              itemExtent: size.width * 0.33,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      height: size.height * 0.16,
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
}
