import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';

class BlurContainer extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final Color textColor;
  final IconData icon1;
  final IconData icon2;
  final VoidCallback onSearchTapped;
  const BlurContainer({
    Key? key,
    required this.text,
    this.height = 50.0,
    this.width = double.infinity,
    this.textColor = Colors.white30,
    this.icon1 = Icons.location_on_outlined,
    this.icon2 = Icons.search,
    required this.onSearchTapped,
  }) : super(key: key);

  @override
  State<BlurContainer> createState() => _BlurContainerState();
}

class _BlurContainerState extends State<BlurContainer> {
  bool animate = true;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 80.0,
      width: widget.width,
      height: widget.height,
      elevation: 5.0,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.icon1,
            color: Colors.white30,
            size: rValue(
              context: context,
              defaultValue: 24.0,
              whenSmaller: 20.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: "Josefin",
                color: widget.textColor,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: rValue(
                  context: context,
                  defaultValue: 14.0,
                  whenSmaller: 12.0,
                ),
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          IconButton(
            icon: const Icon(Icons.search),
            splashColor: Colors.white,
            onPressed: widget.onSearchTapped,
            color: Colors.white30,
            iconSize: rValue(
              context: context,
              defaultValue: 23.0,
              whenSmaller: 20.0,
            ),
          ),
          const SizedBox(width: 7.0),
        ],
      ),
    );
  }
}
