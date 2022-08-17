import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodies/Controllers/recommended_product_controller.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Models/products_model.dart';
import 'package:foodies/Commons/icon_and_text.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  //
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //
        const SizedBox(height: 50.0),

        // ********************** Popular Food Slider **********************

        GetBuilder<PopularProductController>(
          builder: (PopularProductController controller) {
            return AnimationLimiter(
              child: CarouselSlider.builder(
                itemCount: controller.popularProductList.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  //

                  return controller.isLoaded
                      ? _buildPageItems(
                          index,
                          controller.popularProductList[index],
                          context,
                        )
                      : Lottie.asset(
                          "assets/images/loader.json",
                        );
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  disableCenter: true,
                  height: rValue(
                    context: context,
                    defaultValue: 320.0,
                    whenSmaller: 230.0,
                  ),
                  onPageChanged: (int index, _) {
                    setState(() {
                      _activeIndex = index;
                    });
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10.0),

        // ********************** Indicator **********************

        _buildIndicator(),
        const SizedBox(height: 50.0),

        // ********************** Recommended Text **********************

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(bottom: 10.0),
          child: Row(
            children: <Widget>[
              BigText(
                text: "Recommended",
                size: rValue(
                  context: context,
                  defaultValue: 20.0,
                  whenSmaller: 16.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SmallText(
                  text: "   Food pairing",
                  size: rValue(
                    context: context,
                    defaultValue: 13.0,
                    whenSmaller: 11.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),

        // ********************** Recommended Foods List **********************

        GetBuilder<RecommendedProductController>(
          builder: (RecommendedProductController controller) {
            return controller.isLoaded
                ? Column(
                    children: controller.recommendedProductList
                        .map((recommendedProduct) {
                      //

                      int index = controller.recommendedProductList
                          .indexOf(recommendedProduct);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () => toRecommendedFoodPage(index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: <Widget>[
                                //

                                // ********* Image Section *********

                                Container(
                                  width: rValue(
                                    context: context,
                                    defaultValue: 120.0,
                                    whenSmaller: 100.0,
                                  ),
                                  height: rValue(
                                    context: context,
                                    defaultValue: 120.0,
                                    whenSmaller: 100.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${AppConstants.UPLOAD_URL}${recommendedProduct.img}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                // ********* Text Section *********

                                Expanded(
                                  child: Container(
                                    height: rValue(
                                      context: context,
                                      defaultValue: 95.0,
                                      whenSmaller: 70.0,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      color: AppColors.mainBackground,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        BigText(
                                          text: recommendedProduct.name ?? "",
                                          size: rValue(
                                            context: context,
                                            defaultValue: 18.0,
                                            whenSmaller: 15.5,
                                          ),
                                        ),
                                        SmallText(
                                          text:
                                              recommendedProduct.description ??
                                                  "",
                                          size: rValue(
                                            context: context,
                                            defaultValue: 13.0,
                                            whenSmaller: 11.0,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconAndText(
                                              text: "Normal",
                                              icon: Icons.circle_sharp,
                                              iconColor: AppColors.mainYellow,
                                              iconSize: rValue(
                                                context: context,
                                                defaultValue: 17.0,
                                                whenSmaller: 15.0,
                                              ),
                                              textSize: rValue(
                                                context: context,
                                                defaultValue: 12.0,
                                                whenSmaller: 10.0,
                                              ),
                                            ),
                                            IconAndText(
                                              text: "1.7km",
                                              icon: Icons.location_on,
                                              iconColor: AppColors.mainGreen,
                                              iconSize: rValue(
                                                context: context,
                                                defaultValue: 17.0,
                                                whenSmaller: 15.0,
                                              ),
                                              textSize: rValue(
                                                context: context,
                                                defaultValue: 12.0,
                                                whenSmaller: 10.0,
                                              ),
                                            ),
                                            IconAndText(
                                              text: "32min",
                                              icon: Icons.access_time_rounded,
                                              iconColor: AppColors.mainRed,
                                              iconSize: rValue(
                                                context: context,
                                                defaultValue: 17.0,
                                                whenSmaller: 15.0,
                                              ),
                                              textSize: rValue(
                                                context: context,
                                                defaultValue: 12.0,
                                                whenSmaller: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: rValue(
                        context: context,
                        defaultValue: 135.0,
                        whenSmaller: 100.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Lottie.asset(
                        "assets/images/loader2.json",
                      ),
                    ),
                  );
          },
        ),

        const SizedBox(height: 70.0),

        //
      ],
    );
  }

  // ********************** Helper Methods **********************

  Widget _buildPageItems(
      int index, ProductModel popularProduct, BuildContext context) {
    //

    // ********************************** ListView Animation  **********************************

    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 230),
      child: FadeInAnimation(
        curve: Curves.easeInOut,
        child: FadeInAnimation(
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () => toPopularFoodPage(index),
            child: Stack(
              children: <Widget>[
                Container(
                  height: rValue(
                    context: context,
                    defaultValue: 220.0,
                    whenSmaller: 150.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${AppConstants.UPLOAD_URL}${popularProduct.img}"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: rValue(
                      context: context,
                      defaultValue: 120.0,
                      whenSmaller: 80.0,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 30.0)
                        .copyWith(bottom: 30.0),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0)
                        .copyWith(top: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColors.mainBackground,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: AppColors.secondaryBackground,
                          blurRadius: 5.0,
                          offset: Offset(0, 5),
                        ),
                        // BoxShadow(
                        //   color: AppColors.secondaryBackground,
                        //   blurRadius: 5.0,
                        //   offset: Offset(-5, 0),
                        // ),
                        // BoxShadow(
                        //   color: AppColors.secondaryBackground,
                        //   blurRadius: 5.0,
                        //   offset: Offset(5, 0),
                        // ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        BigText(
                          text: popularProduct.name ?? "",
                          size: rValue(
                            context: context,
                            defaultValue: 20.0,
                            whenSmaller: 15.0,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Wrap(
                              children: List.generate(
                                5,
                                (int index) => Icon(
                                  Icons.star,
                                  color: AppColors.mainColor,
                                  size: rValue(
                                    context: context,
                                    defaultValue: 15.0,
                                    whenSmaller: 8.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            SmallText(
                              text: "4.5",
                              size: rValue(
                                context: context,
                                defaultValue: 11.0,
                                whenSmaller: 8.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            SmallText(
                              text: "1287",
                              size: rValue(
                                context: context,
                                defaultValue: 11.0,
                                whenSmaller: 8.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            SmallText(
                              text: "comments",
                              size: rValue(
                                context: context,
                                defaultValue: 11.0,
                                whenSmaller: 9.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconAndText(
                              text: "Normal",
                              icon: Icons.circle_sharp,
                              iconColor: AppColors.mainYellow,
                              iconSize: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 15.0,
                              ),
                              textSize: rValue(
                                context: context,
                                defaultValue: 12.0,
                                whenSmaller: 8.0,
                              ),
                            ),
                            IconAndText(
                              text: "1.7km",
                              icon: Icons.location_on,
                              iconColor: AppColors.mainGreen,
                              iconSize: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 15.0,
                              ),
                              textSize: rValue(
                                context: context,
                                defaultValue: 12.0,
                                whenSmaller: 8.0,
                              ),
                            ),
                            IconAndText(
                              text: "32min",
                              icon: Icons.access_time_rounded,
                              iconColor: AppColors.mainRed,
                              iconSize: rValue(
                                context: context,
                                defaultValue: 20.0,
                                whenSmaller: 15.0,
                              ),
                              textSize: rValue(
                                context: context,
                                defaultValue: 12.0,
                                whenSmaller: 8.0,
                              ),
                            ),
                          ],
                        ),
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
  }

  Widget _buildIndicator() {
    return GetBuilder<PopularProductController>(
      builder: (PopularProductController controller) {
        return AnimatedSmoothIndicator(
          activeIndex: _activeIndex,
          count: controller.popularProductList.isEmpty
              ? 1
              : controller.popularProductList.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: AppColors.secondaryBackground,
            dotColor: AppColors.secondaryBackground,
            dotWidth: 7.0,
            dotHeight: 7.0,
          ),
        );
      },
    );
  }

  void toPopularFoodPage(int index) {
    Get.toNamed(RouteHelper.goToPopularFoodScreen(index, "homePage"));
  }

  void toRecommendedFoodPage(int index) {
    Get.toNamed(RouteHelper.goToRecommendedFoodScreen(index, "homePage"));
  }
}



/*
 ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      cacheExtent: 200.0,
                      shrinkWrap: true, // Imp **

                      itemCount: controller.recommendedProductList.length,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemBuilder: (BuildContext context, int index) {
                        // *** Set Model ***
                        ProductModel recommendedProduct =
                            controller.recommendedProductList[index];

                        // ********************************** ListView Animation  **********************************

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 230),
                          child: SlideAnimation(
                            horizontalOffset: -50.0,
                            child: FadeInAnimation(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                onTap: () => toRecommendedFoodPage(index),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      //

                                      // ********* Image Section *********

                                      Container(
                                        width: rValue(
                                          context: context,
                                          defaultValue: 120.0,
                                          whenSmaller: 100.0,
                                        ),
                                        height: rValue(
                                          context: context,
                                          defaultValue: 120.0,
                                          whenSmaller: 100.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.white38,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${AppConstants.UPLOAD_URL}${recommendedProduct.img}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      // ********* Text Section *********

                                      Expanded(
                                        child: Container(
                                          height: rValue(
                                            context: context,
                                            defaultValue: 95.0,
                                            whenSmaller: 70.0,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0),
                                            ),
                                            color: AppColors.mainBackground,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              BigText(
                                                text: recommendedProduct.name ??
                                                    "",
                                                size: rValue(
                                                  context: context,
                                                  defaultValue: 18.0,
                                                  whenSmaller: 15.5,
                                                ),
                                              ),
                                              SmallText(
                                                text: recommendedProduct
                                                        .description ??
                                                    "",
                                                size: rValue(
                                                  context: context,
                                                  defaultValue: 13.0,
                                                  whenSmaller: 11.0,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  IconAndText(
                                                    text: "Normal",
                                                    icon: Icons.circle_sharp,
                                                    iconColor:
                                                        AppColors.mainYellow,
                                                    iconSize: rValue(
                                                      context: context,
                                                      defaultValue: 17.0,
                                                      whenSmaller: 15.0,
                                                    ),
                                                    textSize: rValue(
                                                      context: context,
                                                      defaultValue: 12.0,
                                                      whenSmaller: 10.0,
                                                    ),
                                                  ),
                                                  IconAndText(
                                                    text: "1.7km",
                                                    icon: Icons.location_on,
                                                    iconColor:
                                                        AppColors.mainGreen,
                                                    iconSize: rValue(
                                                      context: context,
                                                      defaultValue: 17.0,
                                                      whenSmaller: 15.0,
                                                    ),
                                                    textSize: rValue(
                                                      context: context,
                                                      defaultValue: 12.0,
                                                      whenSmaller: 10.0,
                                                    ),
                                                  ),
                                                  IconAndText(
                                                    text: "32min",
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    iconColor:
                                                        AppColors.mainRed,
                                                    iconSize: rValue(
                                                      context: context,
                                                      defaultValue: 17.0,
                                                      whenSmaller: 15.0,
                                                    ),
                                                    textSize: rValue(
                                                      context: context,
                                                      defaultValue: 12.0,
                                                      whenSmaller: 10.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

 */