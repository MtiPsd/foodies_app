import 'package:foodies/Constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:foodies/Data/Api/api_client.dart';

class PopularProductRepo extends GetxService {
//
  final ApiClient apiClient;

  PopularProductRepo({
    required this.apiClient,
  });

  Future<Response> getPopularProductList() async {
    Response response =
        await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    return response;
  }
}
