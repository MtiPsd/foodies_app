import 'package:foodies/Features/Auth/Widgets/custom_text_field.dart';
import 'package:foodies/Features/Auth/Widgets/blur_background.dart';
import 'package:foodies/Features/Auth/Widgets/form_indicator.dart';
import 'package:foodies/Features/Auth/Widgets/form_button.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Models/sign_up_body_model.dart';
import 'package:foodies/Models/response_model.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Commons/small_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:get/get.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    void _registration(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String name = nameController.text.trim();

      if (name.isEmpty) {
        showSnackBar(
          title: "Name",
          text: "Type in your name",
          titleColor: AppColors.mainRed,
        );
      } else if (email.isEmpty) {
        showSnackBar(
          title: "Name",
          text: "Type in your email",
          titleColor: AppColors.mainRed,
        );
      } else if (phone.isEmpty) {
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
      } else if (!GetUtils.isEmail(email)) {
        showSnackBar(
          title: "Invalid email",
          text: "Please enter a valid email address",
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
        SignUpBodyModel signUpBody = SignUpBodyModel(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );

        authController.registration(signUpBody).then((ResponseModel response) {
          if (response.isSuccess) {
            showSnackBar(
              title: "Success",
              text: "Account has been created !",
            );
            Get.offNamed(RouteHelper.goToHomeScreen());
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

        // ************************** Sign up Form **************************

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              CustomTextField(
                label: "Email",
                icon: Icons.email_outlined,
                controller: emailController,
              ),
              CustomTextField(
                label: "Password",
                icon: Icons.password_outlined,
                controller: passwordController,
                obscureText: true,
              ),
              CustomTextField(
                label: "Phone",
                icon: Icons.phone_android_outlined,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                label: "Name",
                icon: Icons.person_outline,
                controller: nameController,
              ),
              const SizedBox(height: 20.0),

              // ************************** Sign up button **************************

              GetBuilder<AuthController>(
                builder: (AuthController authController) {
                  return !authController.isLoading
                      ? FormButton(
                          text: "Sign up",
                          onPressed: () => _registration(authController),
                        )
                      : const FormIndicator();
                },
              ),
              const SizedBox(height: 10.0),

              // ************************** Have an account? **************************

              TextButton(
                onPressed: _goToSignInPage,
                child: const SmallText(
                  text: "Have an account already?",
                  color: Colors.white30,
                ),
              ),
              const SizedBox(height: 10.0),
              const SmallText(
                text: "Sign up using one of the following methods",
                color: Colors.white30,
                size: 10.0,
              ),
              const SizedBox(height: 5.0),

              // ************************** Socials **************************

              Wrap(
                spacing: 15.0,
                children: List.generate(
                  3,
                  (int index) {
                    List<String> socials = [
                      "google.png",
                      "twitter.png",
                      "facebook.png"
                    ];
                    return IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/images/${socials[index]}"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  void _goToSignInPage() {
    Get.back();
  }
}
