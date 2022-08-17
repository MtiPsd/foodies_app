import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Data/Api/api_client.dart';
import 'package:foodies/Models/place_order_model.dart';
import 'package:get/get.dart';

class OrderRepo {
  ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
  });

  Future<Response> placeOrder(PlaceOrderModel placeOrder) async {
    return await apiClient.postData(
      AppConstants.PLACE_ORDER_URI,
      placeOrder.toJson(),
    );
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}
