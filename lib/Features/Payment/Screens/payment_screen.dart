import 'package:webview_flutter/webview_flutter.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Models/order_model.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class PaymentScreen extends StatefulWidget {
  final OrderModel orderModel;
  const PaymentScreen({
    required this.orderModel,
    Key? key,
  }) : super(key: key);

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl =
        '${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,

        // ***************************** Appbar *****************************

        appBar: AppBar(
          toolbarHeight: 120.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: BigText(
            text: "Payment",
            color: Colors.black54,
            size: rValue(
              context: context,
              defaultValue: 20.0,
              whenSmaller: 17.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                onPressed: _backToPrev,
                tooltip: "Log out",
                icon: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: rValue(
                      context: context,
                      defaultValue: 19.0,
                      whenSmaller: 17.0,
                    ),
                  ),
                ),
                color: Colors.grey,
              ),
            ),
          ),
        ),

        // ***************************** Web View *****************************

        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,
                  backgroundColor: Colors.white,
                  userAgent:
                      'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.future
                        .then((value) => controllerGlobal = value);
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {},
                  onPageStarted: (String url) {
                    setState(() {
                      _isLoading = true;
                    });
                    _redirect(url);
                  },
                  onPageFinished: (String url) {
                    setState(() {
                      _isLoading = false;
                    });
                    _redirect(url);
                  },
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    if (_canRedirect) {
      bool isSuccess =
          url.contains('success') && url.contains(AppConstants.BASE_URL);
      bool isFailed =
          url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool isCancel =
          url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
      }
      if (isSuccess) {
        Get.offNamed(
          RouteHelper.goToOrderSuccessScreen(
              widget.orderModel.id.toString(), 'success'),
        );
      } else if (isFailed || isCancel) {
        Get.offNamed(
          RouteHelper.goToOrderSuccessScreen(
              widget.orderModel.id.toString(), 'fail'),
        );
      } else {}
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }

  void _backToPrev() {
    Get.back();
  }
}
