import 'package:flutter/material.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';

class AccountDetail extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isClickable;
  final Color iconColor;
  const AccountDetail({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isClickable = false,
    this.iconColor = AppColors.pizzaRed,
  }) : super(key: key);
//Color.fromARGB(255, 255, 200, 7)
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            rValue(context: context, defaultValue: 30.0, whenSmaller: 20.0),
      ).copyWith(
        bottom: rValue(context: context, defaultValue: 30.0, whenSmaller: 20.0),
      ),
      child: isClickable
          ? TextButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondaryBackground,
                padding: const EdgeInsets.all(20.0),
                elevation: 0.0,
                textStyle: const TextStyle(
                  fontFamily: "Josefin",
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "Josefin",
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
