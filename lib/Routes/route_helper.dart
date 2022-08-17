import 'package:foodies/Features/Location/Screens/pick_location_screen.dart';
import 'package:foodies/Features/Foods/Screens/recommended_food_screen.dart';
import 'package:foodies/Features/Location/Screens/add_location_screen.dart';
import 'package:foodies/Features/Foods/Screens/popular_food_screen.dart';
import 'package:foodies/Features/Payment/Screens/order_success_screen.dart';
import 'package:foodies/Features/Payment/Screens/payment_screen.dart';
import 'package:foodies/Features/Splash/Screens/splash_screen.dart';
import 'package:foodies/Features/Home/Widgets/home_bottom_bar.dart';
import 'package:foodies/Features/Auth/Screens/sign_in_screen.dart';
import 'package:foodies/Features/Auth/Screens/sign_up_screen.dart';
import 'package:foodies/Features/Cart/Screens/cart_screen.dart';
import 'package:foodies/Models/order_model.dart';
import 'package:get/get.dart';

class RouteHelper {
//

  static const String splash = "/splash";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cart = "/cart";
  static const String signUp = "/sign-up";
  static const String signIn = "/sign-in";
  static const String addLocation = "/add-location";
  static const String pickLocation = "/pick-location";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-success";

// ***** For Passing Parameters in our App *****
  static String goToSplashScreen() => splash;
  static String goToHomeScreen() => initial;
  static String goToPopularFoodScreen(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String goToRecommendedFoodScreen(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String goToCartScreen() => cart;
  static String goToSignUpScreen() => signUp;
  static String goToSignInScreen() => signIn;
  static String goToAddLocationScreen() => addLocation;
  static String goToPickLocationScreen() => pickLocation;
  static String goToPaymentScreen(String orderId, int userId) =>
      "$payment?orderId=$orderId&userId=$userId";
  static String goToOrderSuccessScreen(String orderId, String status) =>
      "$orderSuccess?orderId=$orderId&status=$status";

// ****************************************

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: initial,
      page: () => const HomeBottomBar(),
      transition: Transition.fade,
    ),
    GetPage(
      name: popularFood,
      page: () {
        String? id = Get.parameters["pageId"];
        int pageId = int.parse(id!);

        String? page = Get.parameters["page"];

        return PopularFoodScreen(pageId: pageId, page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        String? id = Get.parameters["pageId"];
        int pageId = int.parse(id!);

        String? page = Get.parameters["page"];

        return RecommendedFoodScreen(pageId: pageId, page: page!);
      },
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: cart,
      page: () => const CartScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUp,
      page: () => const SingUpScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: signIn,
      page: () => const SingInScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: addLocation,
      page: () => const AddLocationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: pickLocation,
      page: () {
        PickLocationScreen pickLocationScreen = Get.arguments;

        return pickLocationScreen;
      },
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: payment,
      page: () => PaymentScreen(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['orderId']!),
          userId: int.parse(Get.parameters['userId']!),
        ),
      ),
      // transition: Transition.fadeIn,
    ),
    GetPage(
      name: orderSuccess,
      page: () => OrderSuccessScreen(
        orderId: Get.parameters["orderId"]!,
        status: Get.parameters["status"].toString().contains("success") ? 1 : 0,
      ),
    )
  ];
}
