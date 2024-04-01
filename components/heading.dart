import 'package:flutter/material.dart';
import 'package:movies_app/utils/constants.dart';

class Heading extends StatelessWidget {
  final String title;
  const Heading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
