import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:foodies/Controllers/recommended_product_controller.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Features/Home/Widgets/anim_search_bar.dart';
import 'package:foodies/Features/Home/Widgets/home_body.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<void> _loadResources() async {
    // ******* Init Controllers (GET X) *******
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<LocationController>().getAddressListFromServer();
    // *******************************
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.secondaryBackground,
      color: AppColors.mainRed,
      onRefresh: _loadResources,
      child: Ink(
        color: AppColors.mainBackground,
        child: Column(
          children: <Widget>[
            //
            // ****************************************** Appbar ******************************************

            PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: AppBar(
                toolbarHeight: 120.0,
                elevation: 0.0,
                automaticallyImplyLeading: false,

                // ***************************** Profile Text *****************************
                backgroundColor: AppColors.mainBackground,
                title: Container(
                  margin: const EdgeInsets.only(top: 40.0, bottom: 15.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          BigText(
                            text: "Bangladesh",
                            color: AppColors.mainRed,
                            size: rValue(
                              context: context,
                              defaultValue: 20.0,
                              whenSmaller: 16.0,
                            ),
                          ),
                          Row(
                            children: const <Widget>[
                              SmallText(
                                text: "Narsingdi",
                                color: AppColors.signColor,
                              ),
                              Icon(Icons.arrow_drop_down_rounded),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(
                            rValue(
                              context: context,
                              defaultValue: 10.0,
                              whenSmaller: 8.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: AppColors.mainRed,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black54,
                            size: rValue(
                              context: context,
                              defaultValue: 24.0,
                              whenSmaller: 21.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // ****************************************** Body ******************************************

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
                    stops: [
                      0.0,
                      0.1,
                      0.9,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: const HomeBody(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* 
  PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: AppBar(
                toolbarHeight: 120.0,
                elevation: 0.0,
                automaticallyImplyLeading: false,

                // ***************************** Profile Text *****************************
                backgroundColor: AppColors.mainBackground,
                title: Container(
                  margin: const EdgeInsets.only(top: 40.0, bottom: 15.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          BigText(
                            text: "Bangladesh",
                            color: AppColors.mainRed,
                            size: rValue(
                              context: context,
                              defaultValue: 20.0,
                              whenSmaller: 16.0,
                            ),
                          ),
                          Row(
                            children: const <Widget>[
                              SmallText(
                                text: "Narsingdi",
                                color: AppColors.signColor,
                              ),
                              Icon(Icons.arrow_drop_down_rounded),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(
                            rValue(
                              context: context,
                              defaultValue: 10.0,
                              whenSmaller: 8.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: AppColors.mainRed,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black54,
                            size: rValue(
                              context: context,
                              defaultValue: 24.0,
                              whenSmaller: 21.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

*/
