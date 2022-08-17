import 'package:flutter/material.dart';
import 'package:foodies/Constants/utils.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final EdgeInsetsGeometry padding;
  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color.fromARGB(255, 50, 49, 69),
    this.iconColor = const Color(0xFFa9a29f),
    this.padding = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: rValue(
        context: context,
        defaultValue: 40.0,
        whenSmaller: 35.0,
      ),
      height: rValue(
        context: context,
        defaultValue: 40.0,
        whenSmaller: 35.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0 / 2),
        color: backgroundColor,
      ),
      padding: padding,
      child: Icon(
        icon,
        color: iconColor,
        size: rValue(
          context: context,
          defaultValue: 22.0,
          whenSmaller: 20.0,
        ),
      ),
    );
  }
}
