import 'package:flutter/material.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool mapTextField;
  final Color textColor;
  final bool mapAddress;
  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.emailAddress,
    this.mapTextField = false,
    this.textColor = const Color.fromARGB(255, 28, 27, 43),
    this.mapAddress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !mapTextField
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                icon: Icon(icon),
                label: Text(label),
                errorStyle: const TextStyle(fontFamily: "Josefin"),
                contentPadding: const EdgeInsets.only(bottom: 5.0),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryBackground),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                ),
              ),
              cursorColor: Colors.white30,
              style: const TextStyle(
                fontFamily: "Josefin",
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: controller,
                // expands: false,

                decoration: InputDecoration(
                  icon: Icon(
                    icon,
                    color: AppColors.secondaryBackground,
                  ),
                  label: Text(label),
                  errorStyle: const TextStyle(fontFamily: "Josefin"),
                  contentPadding: const EdgeInsets.only(bottom: 5.0),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.secondaryBackground,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: AppColors.secondaryBackground,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontSize: rValue(
                      context: context,
                      defaultValue: 17.0,
                      whenSmaller: 15.0,
                    ),
                  ),
                ),

                // cursorColor: Colors.red,
                style: TextStyle(
                  fontFamily: "Josefin",
                  fontSize: rValue(
                    context: context,
                    defaultValue: 14.0,
                    whenSmaller: 13.0,
                  ),
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
  }
}
