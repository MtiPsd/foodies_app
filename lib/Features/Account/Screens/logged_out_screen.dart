import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Features/Account/Widgets/log_in_button.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:flutter/material.dart';
import '../../../Constants/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class LoggedOutScreen extends StatelessWidget {
  const LoggedOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            "assets/images/pizza.json",
            width: rValue(
              context: context,
              defaultValue: 250.0,
              whenSmaller: 200.0,
            ),
          ),
          SizedBox(
            width: rValue(
              context: context,
              defaultValue: 250.0,
              whenSmaller: 200.0,
            ),
            height: rValue(
              context: context,
              defaultValue: 50.0,
              whenSmaller: 40.0,
            ),
            child: LogInButton(
              text: "Sign in here",
              onPressed: _toSignInPage,
              textColor: Colors.black,
            ),
          ),
          SizedBox(
            height:
                rValue(context: context, defaultValue: 70.0, whenSmaller: 50.0),
          ),
        ],
      ),
    );
  }

  void _toSignInPage() {
    Get.toNamed(RouteHelper.goToSignInScreen());
  }
}
