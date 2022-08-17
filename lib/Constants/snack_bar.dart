import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required String title,
  required String text,
  Color? titleColor = const Color.fromARGB(255, 112, 139, 82),
}) {
  Get.snackbar(
    "",
    "",
    titleText: Text(
      title,
      style: TextStyle(
        fontFamily: "Josefin",
        color: titleColor,
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    messageText: Text(
      text,
      style: const TextStyle(
        fontFamily: "Josefin",
        fontSize: 13.0,
        color: Colors.white,
      ),
    ),
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(15.0),
    isDismissible: true,
    reverseAnimationCurve: Curves.easeInToLinear,
    barBlur: 100.0,
  );
}
