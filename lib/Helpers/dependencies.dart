import 'package:foodies/Controllers/order_controller.dart';
import 'package:foodies/Controllers/recommended_product_controller.dart';
import 'package:foodies/Data/Repository/order_repo.dart';
import 'package:foodies/Data/Repository/recommended_product_repo.dart';
import 'package:foodies/Controllers/popular_product_controller.dart';
import 'package:foodies/Data/Repository/popular_product_repo.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Data/Repository/location_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Controllers/user_controller.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Data/Repository/auth_repo.dart';
import 'package:foodies/Data/Repository/cart_repo.dart';
import 'package:foodies/Data/Repository/user_repo.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Data/Api/api_client.dart';
import 'package:get/get.dart';

Future<void> init() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  // ******* Api Clinet *******

  Get.lazyPut(() => ApiClient(
        appBaseUrl: AppConstants.BASE_URL,
        sharedPreferences: Get.find(),
      ));

  // ******* Repos *******

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  // ******* Controllers *******

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
