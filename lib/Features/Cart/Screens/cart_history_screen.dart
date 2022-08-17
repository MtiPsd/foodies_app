import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Models/cart_model.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

// ************************** Get List **************************

    List<CartModel> cartHistoryList = Get.find<CartController>()
        .getCartHistoryList()
        .reversed // Use reversed to sort list from newest to oldest
        .toList();

// ************************* Show History Details *************************
    Map<String, int> cartItemsPerOrder = {};

    for (CartModel element in cartHistoryList) {
      if (cartItemsPerOrder.containsKey(element.time)) {
        cartItemsPerOrder.update(element.time!, (int value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(element.time!, () => 1);
      }
    }

    List<int> cartOrderQuantity() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderDateAndTime() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    // ****** Each Order Details ************
    List<int> orderQuantity = cartOrderQuantity();

    List<String> orderDateAndTime = cartOrderDateAndTime();

    /* 
    
      if the list creates for first time , (listCounter) will increase to "1"
      but we need "0" as index for showing pictures! So thats why we're giving it
      "-1" for the first init.
    
    */

    int cartHistoryIndex = -1;
// ************************************************************************

// ****************************** More Order ******************************

    Map<int, CartModel> moreOrders = {};

    void _getMoreOrders(int index) {
      for (CartModel element in cartHistoryList) {
        if (element.time == orderDateAndTime[index]) {
          moreOrders.putIfAbsent(element.id!, () => element);
        }
      }
      Get.find<CartController>().setMoreOrders = moreOrders;
      Get.find<CartController>().addToMoreOrdersList();
      Get.toNamed(RouteHelper.goToCartScreen());
    }

// ************************************************************************

    return Ink(
      color: AppColors.mainBackground,
      child: Stack(
        children: <Widget>[
          //

          // ****************************************** Appbar ******************************************

          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: AppBar(
                toolbarHeight: 120.0,
                automaticallyImplyLeading: false,
                elevation: 0.0,
                title: BigText(
                  text: "Cart History",
                  size: rValue(
                    context: context,
                    defaultValue: 20.0,
                    whenSmaller: 17.0,
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: CircleAvatar(
                      backgroundColor: AppColors.secondaryBackground,
                      child: IconButton(
                        onPressed: _goToCartPage,
                        icon: Icon(
                          Icons.shopping_cart,
                          size: rValue(
                            context: context,
                            defaultValue: 19.0,
                            whenSmaller: 17.0,
                          ),
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
                centerTitle: true,
                backgroundColor: AppColors.mainBackground,
              ),
            ),
          ),

          // ****************************************** Body ******************************************

          orderQuantity.isNotEmpty
              ? Column(
                  children: <Widget>[
                    const SizedBox(height: 120.0),
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (Rect rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.purple,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.purple
                            ],
                            stops: <double>[
                              0.0,
                              0.1,
                              1.9,
                              1.0
                            ], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: AnimationLimiter(
                          child: ListView(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 800),
                              childAnimationBuilder: (Widget widget) =>
                                  SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children: <Widget>[
                                const SizedBox(height: 15.0),
                                for (int i = 0; i < orderQuantity.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0)
                                        .copyWith(bottom: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //

                                        // ***************************** Date And Time *****************************

                                        (() {
                                          DateTime parseDateTime =
                                              DateFormat("yyyy-MM-dd HH:mm:ss")
                                                  .parse(orderDateAndTime[i]);

                                          DateTime inputDateTime =
                                              DateTime.parse(
                                                  parseDateTime.toString());

                                          DateFormat outputFormat =
                                              DateFormat("MM/dd/yyyy hh:mm a");

                                          String outputDateTime = outputFormat
                                              .format(inputDateTime);

                                          return Row(
                                            children: <Widget>[
                                              BigText(
                                                text:
                                                    "    Order Date & Time :    ",
                                                size: rValue(
                                                  context: context,
                                                  defaultValue: 14.0,
                                                  whenSmaller: 12.0,
                                                ),
                                                color: AppColors.mainRed,
                                              ),
                                              BigText(
                                                text: outputDateTime,
                                                size: rValue(
                                                  context: context,
                                                  defaultValue: 14.0,
                                                  whenSmaller: 12.0,
                                                ),
                                                color: AppColors.mainGreen,
                                              ),
                                            ],
                                          );
                                        }()),

                                        // *************************************************************************
                                        const SizedBox(height: 5.0),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color:
                                                AppColors.secondaryBackground,
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 15.0,
                                            top: 15.0,
                                            bottom: 15.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              //

                                              // ***************************** Orders Images *****************************

                                              Expanded(
                                                flex: 0,
                                                child: Wrap(
                                                  direction: Axis.horizontal,
                                                  children: List.generate(
                                                    orderQuantity[i] <= 3
                                                        ? orderQuantity[i]
                                                        : 3,
                                                    (int index) {
                                                      if (cartHistoryIndex <
                                                          cartHistoryList
                                                              .length) {
                                                        cartHistoryIndex++;
                                                      }

                                                      return Container(
                                                        width: rValue(
                                                          context: context,
                                                          defaultValue: 70.0,
                                                          whenSmaller: 60.0,
                                                        ),
                                                        height: rValue(
                                                          context: context,
                                                          defaultValue: 70.0,
                                                          whenSmaller: 60.0,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .only(
                                                          left: 7.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      rValue(
                                                            context: context,
                                                            defaultValue: 33.0,
                                                            whenSmaller: 28.0,
                                                          )),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              AppConstants
                                                                      .UPLOAD_URL +
                                                                  cartHistoryList[
                                                                          cartHistoryIndex]
                                                                      .img!,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),

                                              // ***************************** Total & Add More *****************************

                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  height: rValue(
                                                    context: context,
                                                    defaultValue: 100.0,
                                                    whenSmaller: 80.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      SmallText(
                                                          text: "Total",
                                                          size: rValue(
                                                            context: context,
                                                            defaultValue: 12.0,
                                                            whenSmaller: 10.0,
                                                          )),
                                                      BigText(
                                                        text:
                                                            "${orderQuantity[i]} Items",
                                                        size: rValue(
                                                          context: context,
                                                          defaultValue: 17.0,
                                                          whenSmaller: 15.0,
                                                        ),
                                                      ),

                                                      // ********************* Add More Button *********************

                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            _getMoreOrders(i),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: AppColors
                                                              .mainBackground,
                                                          elevation: 0.0,
                                                          padding:
                                                              EdgeInsets.all(
                                                            rValue(
                                                              context: context,
                                                              defaultValue:
                                                                  12.0,
                                                              whenSmaller: 8.0,
                                                            ),
                                                          ),
                                                        ),
                                                        child: SmallText(
                                                          text: "one more !",
                                                          size: rValue(
                                                            context: context,
                                                            defaultValue: 12.0,
                                                            whenSmaller: 10.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              // ********************************** Cart History Is Empty  **********************************

              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BigText(
                        text: "Your shopping history is empty",
                        color: AppColors.iconColor2,
                        size: rValue(
                          context: context,
                          defaultValue: 18.0,
                          whenSmaller: 16.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Lottie.asset(
                        "assets/images/empty_cart.json",
                        width: rValue(
                          context: context,
                          defaultValue: 150.0,
                          whenSmaller: 140.0,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  void _goToCartPage() {
    Get.toNamed(RouteHelper.goToCartScreen());
  }
}
