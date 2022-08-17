import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Controllers/recommended_product_controller.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Controllers/user_controller.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Future<void> _loadResources() async {
    // ******* Init Controllers (GET X) *******
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    // *******************************
  }

  @override
  void initState() {
    super.initState();

    _loadResources();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..forward();

    Timer(
      const Duration(seconds: 3),
      () {
        Get.toNamed(RouteHelper.goToHomeScreen());
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              "assets/images/logo.json",
              width: rValue(
                context: context,
                defaultValue: 300.0,
                whenSmaller: 250.0,
              ),
              repeat: false,
              controller: _controller,
            ),
            Lottie.asset(
              "assets/images/logo2.json",
              width: rValue(
                context: context,
                defaultValue: 200.0,
                whenSmaller: 150.0,
              ),
              repeat: false,
            ),
          ],
        ),
      ),
    );
  }
}
