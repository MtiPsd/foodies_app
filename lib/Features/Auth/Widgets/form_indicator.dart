import 'package:flutter/material.dart';
import 'package:foodies/Constants/colors.dart';

class FormIndicator extends StatelessWidget {
  const FormIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 22.0,
      height: 22.0,
      child: CircularProgressIndicator(
        color: AppColors.secondaryBackground,
        strokeWidth: 2.5,
      ),
    );
  }
}
