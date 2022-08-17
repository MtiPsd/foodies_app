import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Data/Api/api_client.dart';
import 'package:get/get.dart';

class UserRepo {
//
  final ApiClient apiClient;
  UserRepo({
    required this.apiClient,
  });

// ******************* Get User Info *******************

  Future<Response> getUserInfo() async {
    Response response = await apiClient.getData(AppConstants.USER_INFO_URI);

    return response;
  }
}
