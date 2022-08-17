import 'package:foodies/Data/Repository/order_repo.dart';
import 'package:foodies/Models/order_model.dart';
import 'package:foodies/Models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;

  OrderController({
    required this.orderRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late List<OrderModel> _currentOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;

  late List<OrderModel> _historyOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  Future<void> placeOrder(Function callBack, PlaceOrderModel placeOrder) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);

    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'].toString();
      String orderId = response.body['order_id'].toString();
      callBack(true, message, orderId);
    } else {
      callBack(false, response.statusText, "-1");
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;

    Response response = await orderRepo.getOrderList();

    if (response.statusCode == 200) {
      _currentOrderList = <OrderModel>[];
      _historyOrderList = <OrderModel>[];

      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);

        if (orderModel.orderStatus == "pending" ||
            orderModel.orderStatus == "accepted" ||
            orderModel.orderStatus == "processing" ||
            orderModel.orderStatus == "handover" ||
            orderModel.orderStatus == "picked_up") {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = <OrderModel>[];
      _currentOrderList = <OrderModel>[];
    }
    _isLoading = false;

    update();
  }
}
