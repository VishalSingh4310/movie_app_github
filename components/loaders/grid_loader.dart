import 'package:flutter/material.dart';
import 'package:movies_app/components/skeleton_card.dart';
import 'package:movies_app/utils/constants.dart';

class GridLoader extends StatelessWidget {
  const GridLoader({super.key});

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
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              mainAxisExtent: 230,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: size.height * 0.2,
                    // width: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Skeleton(
                    height: 8,
                    width: size.width * 0.2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Skeleton(
                    height: 8,
                    width: size.width * 0.35,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
