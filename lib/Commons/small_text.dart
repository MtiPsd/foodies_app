import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final double height;
  final TextOverflow overflow;
  const SmallText({
    Key? key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    this.size = 12.0,
    this.height = 1.2,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: "Josefin",
        fontSize: size,
        height: height,
        overflow: overflow,
      ),
    );
  }
}
