import 'package:flutter/material.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Controllers/order_controller.dart';
import 'package:foodies/Features/Order/Widgets/view_order.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLogged;

  @override
  void initState() {
    _isLogged = Get.find<AuthController>().userLoggedIn();

    _tabController = TabController(length: 2, vsync: this);
    // Get order list
    Get.find<OrderController>().getOrderList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isLogged = Get.find<AuthController>().userLoggedIn();

    return Stack(
      children: <Widget>[
        // ****************************************** Appbar ******************************************

        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: AppBar(
              toolbarHeight: 120.0,
              elevation: 0.0,
              automaticallyImplyLeading: false,

              // ***************************** Profile Text *****************************

              title: BigText(
                text: "My Orders",
                size: rValue(
                  context: context,
                  defaultValue: 18.0,
                  whenSmaller: 16.0,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColors.mainBackground,
            ),
          ),
        ),

        // ****************************************** Body ******************************************

        _isLogged
            ? Positioned(
                top: 110.0,
                left: 0.0,
                right: 0.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        controller: _tabController,
                        labelStyle: TextStyle(
                          fontFamily: "Josefin",
                          fontSize: rValue(
                            context: context,
                            defaultValue: 14.0,
                            whenSmaller: 13.0,
                          ),
                        ),
                        indicatorColor: AppColors.secondaryBackground,
                        indicatorWeight: 2.5,
                        labelColor: Colors.white70,
                        unselectedLabelColor: Colors.white24,
                        tabs: const <Widget>[
                          Tab(
                            text: "current",
                          ),
                          Tab(
                            text: "history",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: _tabController,
                        children: const <Widget>[
                          ViewOrder(isCurrent: true),
                          ViewOrder(isCurrent: false),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(bottom: 110.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      "assets/images/fly.json",
                      repeat: false,
                      width: rValue(
                        context: context,
                        defaultValue: 400.0,
                        whenSmaller: 350.0,
                      ),
                    ),
                    BigText(
                      text: "Sign In first to see orders",
                      size: rValue(
                        context: context,
                        defaultValue: 18.0,
                        whenSmaller: 15.0,
                      ),
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
