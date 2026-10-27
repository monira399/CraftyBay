
import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';

class OrderService {

  static Future<NetworkResponse> createOrder({
    required String paymentMethod,
    required Map<String, dynamic> shippingAddress,
    required String redirectUrl,
  }) async {
    final Map<String, dynamic> requestBody = {
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      'redirect_url': redirectUrl,
    };

    final response = await getNetworkCaller().postRequest(
      url: Urls.orderUrl,
      body: requestBody,
    );

    return response;
  }
}
