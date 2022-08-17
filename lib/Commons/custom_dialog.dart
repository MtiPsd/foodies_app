import 'package:flutter/material.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Features/Auth/Widgets/form_button.dart';
import 'package:get/get.dart';

void customDialog({
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  required String text,
  required String title,
}) {
  Get.defaultDialog(
    title: title,
    middleText: text,
    actions: <Widget>[
      const SizedBox(height: 5.0),
      FormButton(
        text: "Cancel",
        onPressed: onCancel,
        color2: AppColors.mainGreen,
      ),
      FormButton(
        text: "Confirm",
        onPressed: onConfirm,
        color2: AppColors.mainRed,
      ),
    ],
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
    titlePadding: const EdgeInsets.only(top: 20.0),
    titleStyle: const TextStyle(
      fontFamily: "Josefin",
      fontWeight: FontWeight.bold,
    ),
    middleTextStyle: const TextStyle(
      fontFamily: "Josefin",
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: AppColors.mainBackground,
  );
}
