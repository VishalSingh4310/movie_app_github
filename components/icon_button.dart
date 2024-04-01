import 'package:flutter/material.dart';

class CustomIconButtom extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final void Function()? onPressed;
  const CustomIconButtom({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                icon,
                color: iconColor ?? Theme.of(context).scaffoldBackgroundColor,
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
