import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Models/sign_in_body_model.dart';
import 'package:foodies/Models/sign_up_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:foodies/Data/Api/api_client.dart';

class AuthRepo {
  //
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

// ******************* Registration *******************

  Future<Response> registration(SignUpBodyModel signUpBodyModel) async {
    // sharedPreferences.remove(AppConstants.TOKEN); // * Debug *
    Response response = await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpBodyModel.toJson());
    return response;
  }

// ******************* Log In *******************

  Future<Response> login(SignInBodyModel signInBodyModel) async {
    Response response = await apiClient.postData(
        AppConstants.LOGIN_URI, signInBodyModel.toJson());
    return response;
  }

// ******************* Save User Token *******************

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

// ******************* Save User Number And Password *******************

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

// ******************* Get User Token *******************

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

// ******************* User Logged In ? *******************

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

// ******************* Clear User Token *******************

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = "";
    apiClient.updateHeader("");

    return true;
  }
}
