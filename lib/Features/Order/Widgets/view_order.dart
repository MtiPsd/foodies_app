import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:foodies/Controllers/order_controller.dart';
import 'package:foodies/Models/order_model.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({
    Key? key,
    required this.isCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (OrderController orderController) {
        if (!orderController.isLoading) {
          late List<OrderModel> orderList;
          if (orderController.currentOrderList.isNotEmpty ||
              orderController.historyOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          } else {
            orderList = <OrderModel>[];
          }

          return orderList.isNotEmpty
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrderModel order = orderList[index];

                        // ****************************** Staggered Animation ******************************

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 230),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.catGreen,
                                          width: 2.0),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(height: 25.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "#Order ID :  ${order.id}",
                                              style: TextStyle(
                                                fontSize: rValue(
                                                  context: context,
                                                  defaultValue: 13.0,
                                                  whenSmaller: 12.0,
                                                ),
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Josefin",
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "${order.orderStatus}",
                                                  style: TextStyle(
                                                    fontSize: rValue(
                                                      context: context,
                                                      defaultValue: 14.0,
                                                      whenSmaller: 13.0,
                                                    ),
                                                    fontWeight: FontWeight.bold,
                                                    color: order.orderStatus ==
                                                                "confirmed" ||
                                                            order.orderStatus ==
                                                                "success"
                                                        ? AppColors.catGreen
                                                        : AppColors.yellowColor,
                                                    fontFamily: "Josefin",
                                                  ),
                                                ),
                                                const SizedBox(height: 15.0),
                                                ElevatedButton(
                                                  onPressed: _trackOrder,
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0.0,
                                                    primary: AppColors
                                                        .secondaryBackground,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Track order",
                                                    style: TextStyle(
                                                      fontSize: rValue(
                                                        context: context,
                                                        defaultValue: 12.0,
                                                        whenSmaller: 11.0,
                                                      ),
                                                      color: Colors.white30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Josefin",
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )

              // ****************************** You have no order ******************************

              : Column(
                  children: <Widget>[
                    const SizedBox(height: 130.0),
                    BigText(
                      text: "No orders found !",
                      size: rValue(
                        context: context,
                        defaultValue: 20.0,
                        whenSmaller: 18.0,
                      ),
                      color: Colors.white70,
                    ),
                    Lottie.asset(
                      "assets/images/no_orders.json",
                      repeat: false,
                      width: rValue(
                        context: context,
                        defaultValue: 200.0,
                        whenSmaller: 160.0,
                      ),
                    ),
                  ],
                );
        }

        // ****************************** Loading ******************************

        else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 180.0),
              Lottie.asset(
                "assets/images/marker-loader.json",
                width: 100.0,
              ),
            ],
          );
        }
      },
    );
  }

  // ****************************** Helper Methods ******************************

  void _trackOrder() {}
}
