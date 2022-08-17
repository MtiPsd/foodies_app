import 'package:flutter/material.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double textSize;
  final Color color1;
  final Color color2;
  final Color textColor;
  final Color iconColor;
  final bool mapButton;
  final IconData icon;
  const FormButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 30.0,
    this.width = double.infinity,
    this.color1 = AppColors.mainBackground,
    this.color2 = const Color.fromARGB(130, 107, 58, 116),
    this.textColor = Colors.white30,
    this.mapButton = false,
    this.icon = Icons.home,
    this.iconColor = AppColors.mainBackground,
    this.textSize = 13.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !mapButton
        ? Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  color1,
                  color2,
                ],
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              child: SmallText(
                text: text,
                size: textSize,
                color: textColor,
              ),
            ),
          )
        : Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  AppColors.secondaryBackground,
                  AppColors.secondaryBackground,
                ],
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
              child: Icon(
                icon,
                color: Colors.white30,
                size: rValue(
                  context: context,
                  defaultValue: 23.0,
                  whenSmaller: 20.0,
                ),
              ),
            ),
          );
  }
}



/* 
Icon(
                icon,
                color: iconColor,
                size: 23.0,
              ),
*/