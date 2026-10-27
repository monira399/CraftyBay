
import 'package:flutter/foundation.dart';

import '../../data/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Map<String, dynamic>? _createdOrder;
  Map<String, dynamic>? get createdOrder => _createdOrder;

  Future<bool> createOrder({
    required String paymentMethod,
    required Map<String, dynamic> shippingAddress,
    required String redirectUrl,
  }) async {
    _createdOrder = null;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await OrderService.createOrder(
        paymentMethod: paymentMethod,
        shippingAddress: shippingAddress,
        redirectUrl: redirectUrl,
      );

      if (response.isSuccess) {
        final responseData = response.responseData;

        if(responseData is Map) {
          final order = responseData['data'];

          if(order is Map) {
            _createdOrder = Map<String, dynamic>.from(order);
            return true;
          }
        }
        _errorMessage = 'order data do not find';
        return false;
      } else {
        _errorMessage = response.errorMassage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
