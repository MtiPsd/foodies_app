import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final double height;
  final double width;
  final bool fromAddress;
  const LoadingContainer({
    Key? key,
    this.height = 50.0,
    this.width = double.infinity,
    required this.fromAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 80,
      width: width,
      height: height,
      elevation: 5.0,
      color: Colors.black54,
      padding: const EdgeInsets.all(0.0),
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Center(
        child: Text(
          fromAddress ? "Pick Address" : "Pick Location",
          style: TextStyle(
            fontFamily: "Josefin",
            color: Colors.white30,
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
