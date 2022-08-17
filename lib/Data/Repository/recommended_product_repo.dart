import 'package:foodies/Constants/app_constants.dart';
import 'package:get/get.dart';

import 'package:foodies/Data/Api/api_client.dart';

class RecommendedProductRepo extends GetxService {
//
  final ApiClient apiClient;
  RecommendedProductRepo({
    required this.apiClient,
  });

// ******************* Get Recommended Product List *******************

  Future<Response> getRecommendedProductList() async {
    Response response =
        await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);

    return response;
  }
}
