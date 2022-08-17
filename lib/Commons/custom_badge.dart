import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodies/Commons/app_icon.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:get/get.dart';

class CustomBadge extends StatelessWidget {
  final PopularProductController controller;
  const CustomBadge({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge:
          Get.find<PopularProductController>().totalItems <= 0 ? false : true,
      badgeContent: SmallText(
        text: "${controller.totalItems}",
        color: Colors.white,
      ),
      animationDuration: const Duration(seconds: 1),
      badgeColor: AppColors.mainRed,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: _goToCartPage,
        child: const AppIcon(
          icon: Icons.shopping_cart_outlined,
        ),
      ),
    );
  }

  void _goToCartPage() {
    Get.toNamed(RouteHelper.goToCartScreen());
  }
}
