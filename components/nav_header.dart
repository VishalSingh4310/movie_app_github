import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/constants.dart';

class NavHeader extends StatelessWidget {
  const NavHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.8,
          child: Container(
            width: 45.0,
            height: 45.0,
            margin: const EdgeInsets.only(
                top: kDefaultPadding, right: kDefaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
