import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:lottie/lottie.dart';

class SaveAddressButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final Color textColor;
  final bool animate;
  final bool fromAddLocationScreen;
  const SaveAddressButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 50.0,
    this.width = double.infinity,
    this.textColor = Colors.white30,
    this.animate = false,
    this.fromAddLocationScreen = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: fromAddLocationScreen ? 45.0 : 80,
      width: width,
      height: height,
      elevation: 5.0,
      color: onPressed == null ? Colors.black54 : Colors.transparent,
      padding: const EdgeInsets.all(0.0),
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Josefin",
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: rValue(
              context: context,
              defaultValue: 14.0,
              whenSmaller: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
