import 'package:foodies/Models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Data/Api/api_client.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData(
      "${AppConstants.GEOCODE_URI}"
      "?lng=${latLng.longitude}&lat=${latLng.latitude}",
    );
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> saveAddress(AddressModel addressModel) async {
    return await apiClient.postData(
      AppConstants.ADD_USER_ADDRESS_URI,
      addressModel.toJson(),
    );
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    /* 
       Every time you want to "SAVE" user info 
       you have to update header (for authentication purpose) 
    */
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);

    return await sharedPreferences.setString(
      AppConstants.USER_ADDRESS,
      userAddress,
    );
  }

  bool clearUserAddress() {
    sharedPreferences.remove(AppConstants.USER_ADDRESS);

    return true;
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData(
      "${AppConstants.ZONE_URI}"
      "?lat=$lat&lng=$lng",
    );
  }

  /*
    Its a GET request NOT POST,
    in POST requests we save somthimg in the server
  */
  // Future<Response> searchLocation(String text) async {
  //   return await apiClient.getData(
  //     "${AppConstants.SEARCH_LOCATION_URI}?search_text=$text",
  //   );
  // }

  // Future<Response> setLocation(String placeId) async {
  //   return await apiClient.getData(
  //     "${AppConstants.PLACE_DETAILS_URI}?placeid=$placeId",
  //   );
  // }
}
