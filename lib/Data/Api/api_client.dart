import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  //
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

// ******************* Update Header *******************

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

// ******************* Get Data *******************

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);

      return response;
    } catch (e) {
      return Response(
        statusCode: 500,
        statusText: e.toString(),
      );
    }
  }

// ******************* Post Data *******************

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response =
          await post(uri, body, headers: _mainHeaders); // Date Sent!
      return response; // Data returned from server!
    } catch (e) {
      return Response(
        statusCode: 500,
        statusText: e.toString(),
      );
    }
  }
}
