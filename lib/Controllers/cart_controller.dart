import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Models/cart_model.dart';
import 'package:foodies/Data/Repository/cart_repo.dart';
import 'package:foodies/Models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
//
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo,
  });

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  // Only for storage and sharedPreferences
  List<CartModel> storageItems = [];

// ******************* Add Items *******************

  void addItems(ProductModel product, int quantity) {
    //
    int totalQuantity = 0;

    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (CartModel value) {
        //

        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          img: value.img,
          price: value.price,
          name: value.name,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      // Remove From Cart if Zero Or Less

      if (totalQuantity <= 0) {
        _items.remove(product.id);
        showSnackBar(
            title: "Success !", text: "Product removed successfully !");
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            img: product.img,
            price: product.price,
            name: product.name,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
        showSnackBar(title: "Success !", text: "Added to your shopping cart !");
      } else {
        showSnackBar(
          title: "Item Count !",
          text: "You should add one item at least !",
          titleColor: AppColors.mainRed,
        );
      }
    }

    cartRepo.addToCartList(getItems); // Save in SharedPreferences

    update(); // Shopping Cart Quantity
  }

// ******************* Exist In Cart *******************

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

// ******************* Get Quantity *******************

  int getQuantity(ProductModel product) {
    int quantity = 0;

    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

// ******************* Get Total Items (Number) *******************

  int get totalItems {
    int totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value
          .quantity!; // if use = instead += , it will apply for only One product !
    });

    return totalQuantity;
  }

// ******************* Get Total Items (Model) *******************

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

// ******************* Get Total Amount *******************

  int get totalAmount {
    int total = 0;

    _items.forEach((key, value) {
      total += value.quantity! *
          value
              .price!; // if use = instead += , it will apply for only One product !
    });

    return total;
  }

  /*
    Call this method when app starts. Because we want previous DATA that saved to the storage before
    and we just want to retrieve it
  */

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();

    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    /*
       After re starting the app we have our data ONLY in (local Strorage). 
       So thats why we are using the code below Again! . 
    */

    for (CartModel item in storageItems) {
      _items.putIfAbsent(item.product!.id!, () => item);
    }
  }

// ******************* Add To History *******************

  void addToHistory() {
    /*
      You have to write it again or some data will be gone after restarting app
    */
    cartRepo.addToCartList(getItems);

    cartRepo.addToCartHistoryList();

    clear();
  }

// ******************* Clear Cart Items *******************

  void clear() {
    _items = {};
    update();
  }

// ******************* Get Cart History List *******************

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

// ******************* Set More Orders *******************

  set setMoreOrders(Map<int, CartModel> moreOrders) {
    _items = {}; // Make sure _items is empty
    _items = moreOrders;
  }

// ******************* Add To More Orders List *******************

  void addToMoreOrdersList() {
    cartRepo.addToCartList(getItems); // Save in SharedPreferences
    update();
  }

// ******************* Clear Cart History *******************

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

// ******************* Remove Cart Shared Preferences *******************

  // void removeCartSharedPreferences() {
  //   cartRepo.removeCartSharedPreferences();
  //   update();
  // }
}
