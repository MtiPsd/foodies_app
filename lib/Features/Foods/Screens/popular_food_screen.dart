import 'package:foodies/Features/Foods/Widgets/info_food_description.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Features/Foods/Widgets/info_top_part.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Models/products_model.dart';
import 'package:foodies/Commons/custom_badge.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Commons/app_icon.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodScreen extends StatelessWidget {
  final int pageId;
  final String page;

  const PopularFoodScreen({
    required this.pageId,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//

    // ****** Call Model ******

    ProductModel product =
        Get.find<PopularProductController>().popularProductList[pageId];

    // ****** Init Cart Controller ******

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    //********************************

    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: SlidingUpPanel(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          maxHeight: MediaQuery.of(context).size.height / 1.2,
          minHeight: rValue(
            context: context,
            defaultValue: MediaQuery.of(context).size.height / 1.65,
            whenSmaller: MediaQuery.of(context).size.height / 1.45,
          ),
          backdropEnabled: true,
          backdropOpacity: 0.2,
          body: Stack(
            children: <Widget>[
              //

              // **************************** Picture ****************************

              Positioned(
                left: 0.0,
                right: 0.0,
                child: Container(
                  width: double.maxFinite,
                  height: rValue(
                    context: context,
                    defaultValue: 360.0,
                    whenSmaller: 260.0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(AppConstants.UPLOAD_URL + product.img!),
                    ),
                  ),
                ),
              ),

              // **************************** Icons ****************************

              Positioned(
                left: 20.0,
                right: 20.0,
                top: 45.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: _backToHomePage,
                      child: const AppIcon(
                        icon: Icons.arrow_back_ios,
                        padding: EdgeInsets.only(left: 5.0),
                      ),
                    ),
                    GetBuilder<PopularProductController>(
                      builder: (PopularProductController controller) {
                        return CustomBadge(controller: controller);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          panel: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: AppColors.secondaryBackground,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //

                  // ******************** Popular Food Top ********************

                  InfoTop(product: product),
                  const SizedBox(height: 30.0),

                  // ********************  Food Description ********************

                  BigText(
                    text: "Introduce",
                    size: rValue(
                      context: context,
                      defaultValue: 20.0,
                      whenSmaller: 17.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  Expanded(
                    child: SingleChildScrollView(
                      child: FoodDescription(
                        text: "${product.description}",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: rValue(
                        context: context,
                        defaultValue: 120.0,
                        whenSmaller: 90.0),
                  ),
                  //
                ],
              ),
            ),
          ),

          // **************************** Footer ****************************

          footer: GetBuilder<PopularProductController>(
            builder: (PopularProductController controller) {
              return Container(
                height: rValue(
                  context: context,
                  defaultValue: 120.0,
                  whenSmaller: 90.0,
                ),
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //

                    // ******************** + - ********************

                    Container(
                      padding: EdgeInsets.all(
                        rValue(
                            context: context,
                            defaultValue: 12.0,
                            whenSmaller: 9.0),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: AppColors.mainBackground,
                      ),
                      child: Row(
                        children: <Widget>[
                          //

                          // **** Decrement ****

                          InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            onTap: () => _quantityDecrement(controller),
                            child: Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                              size: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 15.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),

                          // **** Quantity Text ****

                          Container(
                            width: rValue(
                              context: context,
                              defaultValue: 24.0,
                              whenSmaller: 20.0,
                            ),
                            height: rValue(
                              context: context,
                              defaultValue: 24.0,
                              whenSmaller: 20.0,
                            ),
                            alignment: Alignment.center,
                            child: BigText(
                              text: "${controller.inCartItems}",
                              size: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 16.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),

                          // **** Increment ****

                          InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            onTap: () => _quantityIncrement(controller),
                            child: Icon(
                              Icons.add,
                              color: AppColors.signColor,
                              size: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ******************** Add To Cart  ********************

                    InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      onTap: () => _addItemsToCart(controller, product),
                      child: Container(
                        padding: EdgeInsets.all(
                          rValue(
                              context: context,
                              defaultValue: 20.0,
                              whenSmaller: 12.0),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColors.mainRed,
                        ),
                        child: BigText(
                          text: "\$${product.price} | Add to cart",
                          color: Colors.black,
                          size: rValue(
                            context: context,
                            defaultValue: 20.0,
                            whenSmaller: 18.0,
                          ),
                        ),
                      ),
                    ),

                    //
                  ],
                ),
              );
            },
          )),
    );
  }

  // ****************************** Helper Methods ******************************

  void _backToHomePage() {
    if (page == "cartPage") {
      Get.toNamed(RouteHelper.goToCartScreen());
    } else {
      Get.toNamed(RouteHelper.goToHomeScreen());
    }
  }

  void _quantityIncrement(PopularProductController controller) {
    controller.setQuantity(true);
  }

  void _quantityDecrement(PopularProductController controller) {
    controller.setQuantity(false);
  }

  void _addItemsToCart(
    PopularProductController controller,
    ProductModel product,
  ) {
    controller.addItem(product);
  }
}
