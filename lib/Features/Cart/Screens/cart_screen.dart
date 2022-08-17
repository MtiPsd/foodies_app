import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodies/Controllers/recommended_product_controller.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Controllers/order_controller.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Controllers/user_controller.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Models/place_order_model.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Models/products_model.dart';
import 'package:foodies/Models/address_model.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Models/user_model.dart';
import 'package:foodies/Models/cart_model.dart';
import 'package:foodies/Commons/app_icon.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Stack(
        children: <Widget>[
          //

          // ************************************** Icons  **************************************

          Positioned(
            left: 20.0,
            right: 20.0,
            top: rValue(
              context: context,
              defaultValue: 60.0,
              whenSmaller: 50.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //

                // ********************* Back To Prev *********************
                InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: _backToPrevScreen,
                  child: const AppIcon(
                    icon: Icons.arrow_back_ios,
                  ),
                ),

                SizedBox(
                  width: 90.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: _goToHomePage,
                    child: const AppIcon(
                      icon: Icons.home_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ************************************** Items In Cart **************************************

          Positioned(
            top: rValue(
              context: context,
              defaultValue: 130.0,
              whenSmaller: 115.0,
            ),
            left: 20.0,
            right: 20.0,
            bottom: 0.0,
            child: GetBuilder<CartController>(
              builder: (CartController controller) {
                //

                // ***** Call Model ******

                List<CartModel> cartItems = controller.getItems;

                return cartItems.isNotEmpty
                    ? AnimationLimiter(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (_, index) {
                            //
                            // ******************************************
                            CartModel cartItem = cartItems[index];

                            ProductModel product = cartItem.product!;
                            // ******************************************

                            // ********************************** ListView Animation  **********************************

                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1000),
                              delay: const Duration(milliseconds: 230),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        //

                                        // ********* Image Section *********

                                        InkWell(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                          onTap: () => _goToItemPage(product),
                                          child: Container(
                                            width: rValue(
                                              context: context,
                                              defaultValue: 100.0,
                                              whenSmaller: 90.0,
                                            ),
                                            height: rValue(
                                              context: context,
                                              defaultValue: 90.0,
                                              whenSmaller: 80.0,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45.0),
                                              color: Colors.white38,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  AppConstants.UPLOAD_URL +
                                                      cartItem.img!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // ********* Text Section *********

                                        Expanded(
                                          child: Container(
                                            height: rValue(
                                              context: context,
                                              defaultValue: 90.0,
                                              whenSmaller: 80.0,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ).copyWith(top: 5.0),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20.0),
                                                bottomRight:
                                                    Radius.circular(20.0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                //

                                                // **************************** Food Name ****************************

                                                BigText(
                                                  text: cartItem.name!,
                                                  size: rValue(
                                                    context: context,
                                                    defaultValue: 16.0,
                                                    whenSmaller: 14.5,
                                                  ),
                                                ),
                                                SmallText(
                                                  text: "Spicy",
                                                  size: rValue(
                                                    context: context,
                                                    defaultValue: 12.0,
                                                    whenSmaller: 10.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 5.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    //

                                                    // **************************** Price Text ****************************

                                                    BigText(
                                                      text:
                                                          "\$${cartItem.price!}",
                                                      size: rValue(
                                                        context: context,
                                                        defaultValue: 20.0,
                                                        whenSmaller: 16.5,
                                                      ),
                                                      color:
                                                          AppColors.mainGreen,
                                                    ),

                                                    // **************************** + - ****************************
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                        rValue(
                                                          context: context,
                                                          defaultValue: 10.0,
                                                          whenSmaller: 8.0,
                                                        ),
                                                      ),
                                                      width: 100.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          30.0,
                                                        ),
                                                        color: AppColors
                                                            .mainBackground,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          //

                                                          // **** Decrement ****

                                                          InkWell(
                                                            onTap: () =>
                                                                _removeItemFromCart(
                                                              product,
                                                              controller,
                                                            ),
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor,
                                                              size: rValue(
                                                                context:
                                                                    context,
                                                                defaultValue:
                                                                    20.0,
                                                                whenSmaller:
                                                                    15.0,
                                                              ),
                                                            ),
                                                          ),

                                                          // **** Number of Product ****

                                                          Container(
                                                            width: rValue(
                                                              context: context,
                                                              defaultValue:
                                                                  24.0,
                                                              whenSmaller: 18.0,
                                                            ),
                                                            height: rValue(
                                                              context: context,
                                                              defaultValue:
                                                                  24.0,
                                                              whenSmaller: 18.0,
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: BigText(
                                                              text:
                                                                  "${cartItem.quantity}",
                                                              size: rValue(
                                                                context:
                                                                    context,
                                                                defaultValue:
                                                                    17.0,
                                                                whenSmaller:
                                                                    16.0,
                                                              ),
                                                            ),
                                                          ),
                                                          // **** Increment ****

                                                          InkWell(
                                                            onTap: () =>
                                                                _addItemsToCart(
                                                              product,
                                                              controller,
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor,
                                                              size: rValue(
                                                                context:
                                                                    context,
                                                                defaultValue:
                                                                    20.0,
                                                                whenSmaller:
                                                                    15.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )

                    // ************************************** No Orders Found **************************************

                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BigText(
                            text: "Nothing found !",
                            size: rValue(
                              context: context,
                              defaultValue: 18.0,
                              whenSmaller: 16.0,
                            ),
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 20.0),
                          Lottie.asset(
                            "assets/images/shopping-empty.json",
                            repeat: false,
                            width: rValue(
                              context: context,
                              defaultValue: 200.0,
                              whenSmaller: 160.0,
                            ),
                          ),
                        ],
                      );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (CartController controller) {
          // ***** Call Model ******

          List<CartModel> cartItems = controller.getItems;

          return cartItems.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //

                    // ****************************** Add To Cart ******************************

                    Container(
                      height: rValue(
                        context: context,
                        defaultValue: 100.0,
                        whenSmaller: 90.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 0.0),
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

                          // ******************** Total Amount ********************

                          Container(
                            width: rValue(
                              context: context,
                              defaultValue: 60.0,
                              whenSmaller: 50.0,
                            ),
                            height: rValue(
                              context: context,
                              defaultValue: 60.0,
                              whenSmaller: 50.0,
                            ),
                            alignment: Alignment.center,
                            child: BigText(
                              text: "\$ ${controller.totalAmount}",
                              size: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 16.0,
                              ),
                            ),
                          ),

                          // ******************** Check Out ********************

                          InkWell(
                            onTap: () => _checkOutPressed(controller),
                            borderRadius: BorderRadius.circular(15.0),
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
                                text: "Check out",
                                color: Colors.white,
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
                )
              : const Text("");
        },
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  void _goToHomePage() {
    Get.toNamed(RouteHelper.goToHomeScreen());
  }

  void _addItemsToCart(ProductModel product, CartController controller) {
    controller.addItems(product, 1);
  }

  void _removeItemFromCart(ProductModel product, CartController controller) {
    controller.addItems(product, -1);
  }

  void _goToItemPage(ProductModel product) {
    //

    int popularIndex = Get.find<PopularProductController>()
        .popularProductList
        .indexOf(product);

    if (popularIndex >= 0) {
      Get.toNamed(RouteHelper.goToPopularFoodScreen(popularIndex, "cartPage"));
    } else {
      int recommendedIndex = Get.find<RecommendedProductController>()
          .recommendedProductList
          .indexOf(product);
      if (recommendedIndex < 0) {
        showSnackBar(
          title: "History Product",
          text: "Product review is not available for history products !",
          titleColor: AppColors.mainRed,
        );
      } else {
        Get.toNamed(RouteHelper.goToRecommendedFoodScreen(
            recommendedIndex, "cartPage"));
      }
    }
  }

  void _checkOutPressed(CartController cartController) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (userLoggedIn) {
      // cartController.addToHistory();
      bool hasEmptyAddress = Get.find<LocationController>().addressList.isEmpty;

      if (hasEmptyAddress) {
        Get.toNamed(RouteHelper.goToAddLocationScreen());
      } else {
        /* 
           Here we send a lot of data
        */
        _goToPaymentScreen();
      }
    } else {
      Get.toNamed(RouteHelper.goToSignInScreen());
    }
  }

  void _backToPrevScreen() {
    Get.back();
  }

  void _callBack(bool isSuccess, String message, String orderId) {
    if (isSuccess) {
      /* 
         Use Future.delayed , so products
         will be deleted from UI after user goes to
         payment page
      */
      Future.delayed(
        const Duration(seconds: 5),
        () => Get.find<CartController>().addToHistory(),
      );

      int userId = Get.find<UserController>().userModel.id;
      Get.toNamed(
        RouteHelper.goToPaymentScreen(orderId, userId),
      );
    } else {
      showSnackBar(
        title: "Payment",
        text: message,
        titleColor: AppColors.mainRed,
      );
    }
  }

  void _goToPaymentScreen() {
    //
    AddressModel location = Get.find<LocationController>().getUserAddress();
    List<CartModel> cart = Get.find<CartController>().getItems;
    UserModel user = Get.find<UserController>().userModel;
    PlaceOrderModel placeOrder = PlaceOrderModel(
      cart: cart,
      orderAmount: 100.0,
      distance: 10.0,
      scheduleAt: " ",
      orderNote: "Not About The Food",
      address: location.address,
      latitude: location.latitude!,
      longitude: location.longitude!,
      contactPersonName: user.name,
      contactPersonNumber: user.phone,
    );
    Get.find<OrderController>().placeOrder(_callBack, placeOrder);
  }
}
