import 'package:flutter/material.dart';

class SkeletonCard extends StatelessWidget {
  final double? height;
  final double? width;
  const SkeletonCard({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeleton(
          height: height ?? 120,
          width: width ?? 120,
        ),
        const SizedBox(
          height: 5,
        ),
        const Expanded(
            child: Column(
          children: [
            Skeleton(
              width: 80,
            )
          ],
        ))
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;
  const Skeleton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 10,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
