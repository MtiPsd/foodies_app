import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BlurBackground extends StatelessWidget {
  final Widget child;
  const BlurBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            Lottie.asset(
              "assets/images/logo-s.json",
              width: 150.0,
              height: 150.0,
              repeat: true,
              reverse: true,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Lottie.asset(
                      "assets/images/shine.json",
                      width: 319.0,
                      height: 460.0,
                      repeat: true,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  child: BlurryContainer(
                    blur: 50.0,
                    width: 320.0,
                    height: 460.0,
                    elevation: 10.0,
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    child: child,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 150.0),
          ],
        ),
      ),
    );
  }
}
