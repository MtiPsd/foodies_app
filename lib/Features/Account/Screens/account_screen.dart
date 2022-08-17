import 'package:foodies/Features/Account/Screens/logged_out_screen.dart';
import 'package:foodies/Features/Account/Widgets/account_detail.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Controllers/user_controller.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Commons/custom_dialog.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final ScrollController _scrollController = ScrollController();

    // ****** Find Controllers ******
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Ink(
      color: AppColors.mainBackground,
      child: GetBuilder<UserController>(
        builder: (UserController userController) {
          return userLoggedIn
              ? Stack(
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
                          elevation: 0.0,
                          automaticallyImplyLeading: false,
                          // ***************************** Profile Text *****************************

                          title: BigText(
                            text: "Profile",
                            size: rValue(
                              context: context,
                              defaultValue: 20.0,
                              whenSmaller: 17.0,
                            ),
                          ),
                          centerTitle: true,
                          backgroundColor: AppColors.mainBackground,
                          actions: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: CircleAvatar(
                                backgroundColor: AppColors.secondaryBackground,
                                child: IconButton(
                                  onPressed: _logOut,
                                  tooltip: "Log out",
                                  icon: Icon(
                                    Icons.power_settings_new,
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
                        ),
                      ),
                    ),

                    // ****************************************** Body ******************************************

                    userController.isLoading
                        ? SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 120.0),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: rValue(
                                      context: context,
                                      defaultValue: 30.0,
                                      whenSmaller: 20.0,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: rValue(
                                    context: context,
                                    defaultValue: 190.0,
                                    whenSmaller: 160.0,
                                  ),
                                  decoration: const ShapeDecoration(
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    color: AppColors.secondaryBackground,
                                  ),
                                  child: Lottie.asset(
                                    "assets/images/pizza.json",
                                  ),
                                ),
                                const SizedBox(height: 10.0),
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
                                    child: ListView(
                                      controller: _scrollController,
                                      cacheExtent: 200.0,
                                      children: <Widget>[
                                        //
                                        // ***************************** Scroll Up *****************************

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Lottie.asset(
                                              "assets/images/scrollup.json",
                                              width: rValue(
                                                context: context,
                                                defaultValue: 50.0,
                                                whenSmaller: 40.0,
                                              ),
                                              height: rValue(
                                                context: context,
                                                defaultValue: 50.0,
                                                whenSmaller: 40.0,
                                              ),
                                            ),
                                            Lottie.asset(
                                              "assets/images/scrollup.json",
                                              width: rValue(
                                                context: context,
                                                defaultValue: 50.0,
                                                whenSmaller: 40.0,
                                              ),
                                              height: rValue(
                                                context: context,
                                                defaultValue: 50.0,
                                                whenSmaller: 40.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // ***************************** Name *****************************

                                        AccountDetail(
                                          onTap: () {},
                                          icon: Icons.person_outline,
                                          title: userController.userModel.name,
                                        ),

                                        // ***************************** Phone *****************************

                                        AccountDetail(
                                          onTap: () {},
                                          icon: Icons.phone_outlined,
                                          title: userController.userModel.phone,
                                        ),

                                        // ***************************** Email *****************************

                                        AccountDetail(
                                          onTap: () {},
                                          icon: Icons.email_outlined,
                                          title: userController.userModel.email,
                                        ),

                                        // ***************************** Location *****************************

                                        GetBuilder<LocationController>(
                                          builder: (
                                            LocationController
                                                locationController,
                                          ) {
                                            return AccountDetail(
                                              icon: Icons.location_on_outlined,
                                              title: locationController
                                                      .addressList.isEmpty
                                                  ? "Fill in the address"
                                                  : "Your Address",
                                              isClickable: true,
                                              iconColor: locationController
                                                      .addressList.isEmpty
                                                  ? AppColors.mainRed
                                                  : AppColors.mainGreen,
                                              onTap: _onLocationTap,
                                            );
                                          },
                                        ),

                                        // ***************************** None *****************************

                                        AccountDetail(
                                          onTap: () {},
                                          icon: Icons.message_outlined,
                                          title: "none",
                                        ),

                                        // ***************************** Log Out *****************************

                                        // AccountDetail(
                                        //   onTap: _logOut,
                                        //   icon: Icons.logout_outlined,
                                        //   title: "Log out",
                                        //   isClickable: true,
                                        // ),
                                        const SizedBox(height: 10.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 90.0),
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: rValue(
                                    context: context,
                                    defaultValue: 100.0,
                                    whenSmaller: 70.0,
                                  ),
                                ),
                                height: rValue(
                                  context: context,
                                  defaultValue: 150.0,
                                  whenSmaller: 100.0,
                                ),
                                child: Lottie.asset(
                                  "assets/images/loader3.json",
                                ),
                              ),
                            ),
                          ),
                  ],
                )

              // ***************************** You Must Log In  *****************************

              : const LoggedOutScreen();
        },
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  void _logOut() {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();

    customDialog(
      title: "Warning",
      text: "Are you sure ?",
      onConfirm: () {
        if (userLoggedIn) {
          Get.find<AuthController>().clearSharedData();
          Get.find<CartController>().clear();
          Get.find<CartController>().clearCartHistory();
          Get.find<LocationController>().clearAddressData();
          Get.offNamed(RouteHelper.goToSignInScreen());
        } else {
          showSnackBar(
            title: "Failed",
            text: "You must log in first !",
            titleColor: AppColors.mainRed,
          );
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void _onLocationTap() {
    Get.toNamed(RouteHelper.goToAddLocationScreen());
  }
}
