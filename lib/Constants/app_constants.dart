// ignore_for_file: constant_identifier_names

class AppConstants {
//

// App Details

  static const String APP_NAME = "Foody";
  static const int APP_VERSION = 1;

// Url

  //"https://mtipsd.iran.liara.run"
  //"http://192.168.1.104:8000"
  static const String BASE_URL = "http://192.168.1.102:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "$BASE_URL/uploads/";
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";
  static const String ADD_USER_ADDRESS_URI = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  // static const String SEARCH_LOCATION_URI =
  //     "/api/v1/config/place-api-autocomplete";
  // static const String PLACE_DETAILS_URI = "/api/v1/config/place-api-details";
  static const String PLACE_ORDER_URI = "/api/v1/customer/order/place";
  static const String ORDER_LIST_URI = "/api/v1/customer/order/list";

// Token

  static const String TOKEN = "app-token";

// Phone Password

  static const String PHONE = "user-phone";
  static const String PASSWORD = "user-pass";

// User Address

  static const String USER_ADDRESS = "user-address";

// Key

  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

// Map
  static const String MAP_TEMPLATE =
      "https://api.mapbox.com/styles/v1/mtipsd/cl65ezaxn003j14m8tozb6l9r/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}";

  static const String PACKAGE_NAME = 'com.example.foodies';

  static const String PUBLIC_KEY =
      'pk.eyJ1IjoibXRpcHNkIiwiYSI6ImNsNXhqc2NzNTBuNXozaXBzb3ZjNGJva2UifQ.F-JtKe6AYSw8G2TVcmF6yA';

  static const Map<String, String> ADDITIONAL_OPTIONS = <String, String>{
    "access_token":
        "pk.eyJ1IjoibXRpcHNkIiwiYSI6ImNsNXhqc2NzNTBuNXozaXBzb3ZjNGJva2UifQ.F-JtKe6AYSw8G2TVcmF6yA",
    "id": "mapbox.mapbox-streets-v8"
  };
}
