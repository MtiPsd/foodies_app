import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';

class FoodDescription extends StatefulWidget {
  final String text;
  const FoodDescription({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<FoodDescription> createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription> {
  @override
  Widget build(BuildContext context) {
    //

    return ExpandableText(
      widget.text,
      expandText: 'Show more',
      collapseText: "Show less",
      maxLines: 4,
      linkColor: AppColors.mainColor,
      animation: true,
      style: TextStyle(
        color: const Color(0xFFccc7c5),
        fontFamily: "Josefin",
        fontSize: rValue(
          context: context,
          defaultValue: 14.0,
          whenSmaller: 12.5,
        ),
        height: 1.3,
        overflow: TextOverflow.ellipsis,
      ),
      collapseOnTextTap: true,
      expandOnTextTap: true,
      animationCurve: Curves.easeInOut,
    );
  }
}
