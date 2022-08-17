import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Helpers/dependencies.dart' as dep;
import 'package:foodies/Constants/dimensions.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter Needs Run Native Code
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    Get.find<CartController>().getCartData();

    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) =>
          Dimensions(child: child!),
      initialRoute: RouteHelper.goToSplashScreen(),
      getPages: RouteHelper.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.white30,
            ),
      ),
    );
  }
}
