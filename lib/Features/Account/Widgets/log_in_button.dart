import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color textColor;
  const LogInButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 50.0,
    this.width = double.infinity,
    this.textColor = Colors.white30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 45.0,
      width: width,
      height: height,
      elevation: 5.0,
      color: Colors.transparent,
      padding: const EdgeInsets.all(0.0),
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontFamily: "Josefin",
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: rValue(
                  context: context,
                  defaultValue: 13.0,
                  whenSmaller: 11.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(
              Icons.login_outlined,
              color: Colors.black,
              size: rValue(
                context: context,
                defaultValue: 20.0,
                whenSmaller: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
