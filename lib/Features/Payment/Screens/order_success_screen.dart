import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  final int status;
  const OrderSuccessScreen({
    Key? key,
    required this.orderId,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                status == 1
                    ? "assets/images/payment-success.json"
                    : "assets/images/payment-failed.json",
                width: rValue(
                  context: context,
                  defaultValue: 250.0,
                  whenSmaller: 220.0,
                ),
                height: rValue(
                  context: context,
                  defaultValue: status == 1 ? 250.0 : 300.0,
                  whenSmaller: status == 1 ? 220.0 : 270.0,
                ),
                repeat: false,
              ),
              BigText(
                text: status == 1 ? "Payment Successful" : "Payment Failed",
              ),
              const SizedBox(height: 50.0),
              TextButton(
                onPressed: _backToHome,
                child: const SmallText(
                  text: "Back to home",
                  color: Colors.white30,
                ),
              )
            ],
          ),
        ));
  }

  void _backToHome() {
    Get.offAllNamed(RouteHelper.goToHomeScreen());
  }
}
