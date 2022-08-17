import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Controllers/cart_controller.dart';
import 'package:foodies/Data/Repository/popular_product_repo.dart';
import 'package:foodies/Models/cart_model.dart';
import 'package:foodies/Models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
//
  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

// ******************* Get Popular Product List *******************

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = []; // Data Not Repeated

      _popularProductList.addAll(
        Product.fromJson(response.body).products,
      );

      _isLoaded = true;

      update(); // Update UI
    } else {}
  }

// ******************* Set Quantity *******************

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }

    update();
  }

// ******************* Check Quantity *******************

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      showSnackBar(
        title: "Item Count !",
        text: "You can't reduce more!",
        titleColor: AppColors.mainRed,
      );

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }

      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      showSnackBar(
        title: "Item Count !",
        text: "You can't add more!",
        titleColor: AppColors.mainRed,
      );

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 20;
    } else {
      return quantity;
    }
  }

// ******************* Init Product *******************

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;

    // *** If Item Exist ***

    bool exists = false;
    exists = _cart.existInCart(product);

    if (exists) {
      _inCartItems = _cart.getQuantity(product);
    }
    // *** Get From Storage ***
  }

// ******************* Add Item *******************

  void addItem(ProductModel product) {
    _cart.addItems(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    update(); // Badge
  }

// ******************* Get Total Items (Numbers) *******************

  int get totalItems {
    return _cart.totalItems;
  }

// ******************* Get Total Items (Models) *******************

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
