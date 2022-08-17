import 'package:foodies/Features/Foods/Widgets/info_food_description.dart';
import 'package:foodies/Controllers/recommended_product_controller.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Models/products_model.dart';
import 'package:foodies/Commons/custom_badge.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Commons/app_icon.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedFoodScreen extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodScreen({
    required this.pageId,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    // ******* Call Model *******

    ProductModel product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];

    // ****** Init Cart Controller ******

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    //**********************************

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: CustomScrollView(
        slivers: <Widget>[
          //

// **************************** Picture & Icons ****************************

          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.mainBackground,
            expandedHeight: 300.0,
            toolbarHeight: 90.0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //

                // ******* Back To Home Icon *******

                InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: _backToHomePage,
                  child: const AppIcon(icon: Icons.clear),
                ),
                // ******* Shopping Cart *******
                GetBuilder<PopularProductController>(
                  builder: (PopularProductController controller) {
                    return CustomBadge(controller: controller);
                  },
                ),
              ],
            ),

            // ************ Food Image ************

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),

            // ************ Food Name ************

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20.0),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: const BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0),
                    topRight: Radius.circular(80.0),
                  ),
                ),
                child: Center(
                  child: BigText(
                    text: product.name!,
                    size: rValue(
                      context: context,
                      defaultValue: 20.0,
                      whenSmaller: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

// **************************** Body Food Info ****************************

          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FoodDescription(
                    text: product.description!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

// **************************** Footer ****************************

      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (PopularProductController controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //

              // ****************************** - +  ******************************

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50.0)
                    .copyWith(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //

                    // **************** Decrement  ****************

                    InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () => _quantityDecrement(controller),
                      child: const AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainBackground,
                        iconColor: AppColors.signColor,
                      ),
                    ),

                    // **************** Price and Quantity Text  ****************

                    SizedBox(
                      width: rValue(
                        context: context,
                        defaultValue: 95.0,
                        whenSmaller: 85.0,
                      ),
                      height: rValue(
                        context: context,
                        defaultValue: 20.0,
                        whenSmaller: 20.0,
                      ),
                      child: BigText(
                        text:
                            " \$${product.price!} X ${controller.inCartItems} ",
                        color: AppColors.signColor,
                        size: rValue(
                          context: context,
                          defaultValue: 21.5,
                          whenSmaller: 20.0,
                        ),
                      ),
                    ),

                    // **************** Increment  ****************

                    InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () => _quantityIncrement(controller),
                      child: const AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainBackground,
                        iconColor: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),

              // ****************************** Add To Cart ******************************

              Container(
                height: rValue(
                  context: context,
                  defaultValue: 100.0,
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

                    // ******************** Favorite Icon ********************

                    Container(
                      padding: EdgeInsets.all(
                        rValue(
                          context: context,
                          defaultValue: 13.0,
                          whenSmaller: 10.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.mainBackground,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainRed,
                        size: rValue(
                          context: context,
                          defaultValue: 20.0,
                          whenSmaller: 15.0,
                        ),
                      ),
                    ),

                    // ******************** Add To Cart Button ********************

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
                          text: "\$${product.price!} | Add to cart",
                          color: Colors.black,
                          size: rValue(
                              context: context,
                              defaultValue: 20.0,
                              whenSmaller: 18.0),
                        ),
                      ),
                    ),

                    //
                  ],
                ),
              ),

              //
            ],
          );
        },
      ),
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
