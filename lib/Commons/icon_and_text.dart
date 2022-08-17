import 'package:flutter/material.dart';
import 'package:foodies/Commons/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double? iconSize;
  final double? textSize;
  const IconAndText({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.iconSize,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(width: 5.0),
        SmallText(
          text: text,
          size: textSize ?? 12.0,
        ),
      ],
    );
  }
}
