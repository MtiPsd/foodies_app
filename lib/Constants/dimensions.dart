import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';

// Main App Dimension
// Widget dimensions(BuildContext context, Widget? child) =>
//     ResponsiveWrapper.builder(
//       ClampingScrollWrapper.builder(context, child!),
//       breakpoints: <ResponsiveBreakpoint>[
//         const ResponsiveBreakpoint.resize(350.0, name: MOBILE),
//         const ResponsiveBreakpoint.autoScale(600.0, name: TABLET),
//         const ResponsiveBreakpoint.resize(800.0, name: DESKTOP),
//         const ResponsiveBreakpoint.autoScale(1700.0, name: "XL"),
//       ],
//     );

class Dimensions extends StatelessWidget {
  final Widget child;
  const Dimensions({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper.builder(
      ClampingScrollWrapper.builder(context, child),
      breakpoints: <ResponsiveBreakpoint>[
        const ResponsiveBreakpoint.resize(350.0, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(600.0, name: TABLET),
        const ResponsiveBreakpoint.resize(800.0, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(1700.0, name: "XL"),
      ],
    );
  }
}
