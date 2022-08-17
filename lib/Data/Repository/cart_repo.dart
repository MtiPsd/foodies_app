import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Models/cart_model.dart';
import 'dart:convert';

class CartRepo {
  //
  final SharedPreferences sharedPreferences;
  CartRepo({
    required this.sharedPreferences,
  });

  List<String> cart = <String>[];
  List<String> cartHistory = <String>[];

// ******************* Add To Cart List *******************

  void addToCartList(List<CartModel> cartList) {
    //

    // sharedPreferences.remove(AppConstants.CART_LIST); // * Debug *
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST); // * Debug *
    // return; // * Debug *

    cart = <String>[];

    String time = DateTime.now().toString();

    for (CartModel element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

// ******************* Get Cart List *******************

  List<CartModel> getCartList() {
    //
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];

    for (String element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }

// ******************* Add To Cart History List *******************

  void addToCartHistoryList() {
    //

    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (String element in cart) {
      cartHistory.add(element);
    }

    removeCart();

    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
  }

// ******************* Remove Cart *******************

  void removeCart() {
    cart = <String>[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

// ******************* Get Cart History List *******************

  List<CartModel> getCartHistoryList() {
    //
    List<String> cartsHistory = [];

    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartsHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartHistoryList = [];

    for (String elements in cartsHistory) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(elements)));
    }

    return cartHistoryList;
  }

// ******************* Clear Cart History *******************

  void clearCartHistory() {
    removeCart();
    cartHistory = <String>[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

// ******************* Remove Cart Shared Preferences *******************

  // void removeCartSharedPreferences() {
  //   sharedPreferences.remove(AppConstants.CART_LIST);
  //   sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  // }
}
