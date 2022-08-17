import 'package:foodies/Features/Auth/Widgets/custom_text_field.dart';
import 'package:foodies/Features/Auth/Widgets/blur_background.dart';
import 'package:foodies/Features/Auth/Widgets/form_indicator.dart';
import 'package:foodies/Features/Auth/Widgets/form_button.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Models/response_model.dart';
import 'package:foodies/Models/sign_in_body_model.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showSnackBar(
          title: "Phone number",
          text: "Type in your phone number",
          titleColor: AppColors.mainRed,
        );
      } else if (password.isEmpty) {
        showSnackBar(
          title: "Password",
          text: "Type in your password",
          titleColor: AppColors.mainRed,
        );
      } else if (password.length < 6) {
        showSnackBar(
          title: "Password",
          text: "Password can't be less then six characters",
          titleColor: AppColors.mainRed,
        );
      } else if (phone.length < 11) {
        showSnackBar(
          title: "Phone",
          text: "Wrong phone number",
          titleColor: AppColors.mainRed,
        );
      } else {
        SignInBodyModel signInBody = SignInBodyModel(
          phone: phone,
          password: password,
        );
        authController.login(signInBody).then((ResponseModel response) {
          if (response.isSuccess) {
            Get.toNamed(RouteHelper.goToHomeScreen());
            showSnackBar(
              title: "Success",
              text: "Logged in successfully",
            );
          } else {
            showSnackBar(
              title: "Failed",
              text: response.message,
              titleColor: AppColors.mainRed,
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: BlurBackground(
        //

        // ************************** Sign in Form **************************

        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 30.0),
                    CustomTextField(
                      label: "Phone",
                      icon: Icons.phone_outlined,
                      controller: phoneController,
                    ),
                    CustomTextField(
                      label: "Password",
                      icon: Icons.password_outlined,
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                // ************************** Sign ip button **************************

                GetBuilder<AuthController>(
                  builder: (AuthController authController) {
                    return !authController.isLoading
                        ? FormButton(
                            text: "Sign in",
                            onPressed: () => _login(authController),
                            height: 40.0,
                          )
                        : const FormIndicator();
                  },
                ),
                const SizedBox(height: 30.0),

                // ************************** Don't have an account? **************************

                const SmallText(
                  text: "Don't have an account?",
                  color: Colors.white30,
                ),

                TextButton(
                  onPressed: _goToSignUpPage,
                  child: const SmallText(
                    text: "create !",
                    color: Colors.white30,
                    size: 15.0,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  void _goToSignUpPage() {
    Get.toNamed(RouteHelper.goToSignUpScreen());
  }
}
