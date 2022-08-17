import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final TextOverflow overflow;
  final Color? color;
  final FontWeight fontWeight;

  const BigText({
    Key? key,
    required this.text,
    this.color = const Color.fromARGB(255, 219, 219, 219),
    this.size = 20.0,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontFamily: "Josefin",
        fontSize: size,
        overflow: overflow,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
