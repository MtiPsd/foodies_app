import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.goToSignInScreen());
    } else {
      showSnackBar(
        title: "Error",
        text: response.statusText!,
        titleColor: AppColors.mainRed,
      );
    }
  }
}
