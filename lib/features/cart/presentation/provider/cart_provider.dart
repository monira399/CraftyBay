import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:flutter/cupertino.dart';

import '../../data/ models/cart_item_model.dart';

class CartItemProvider extends ChangeNotifier {
  bool _cartItemInProgress = false;
  bool get cartItemInProgress => _cartItemInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CartItemModel> _cartItems = [];
  List<CartItemModel> get cartItems => _cartItems;

  Future<void> getCartItems() async {
    _cartItemInProgress = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final NetworkResponse response = await getNetworkCaller().getRequest(
        url: Urls.addToCartUrl,
      );

      if (response.isSuccess) {
        final results = response.responseData['data']['results'] as List;

        _cartItems = results
            .map(
              (item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      } else {
        _errorMessage = response.errorMassage ?? 'Failed to load cart items';
      }
    } catch (e) {
      _errorMessage = 'Something went wrong while loading cart items.';
    } finally {
      _cartItemInProgress = false;
      notifyListeners();
    }
  }

  num get totalPrice {
   return _cartItems.fold(
   0,
       (sum, item) => sum + (item.product.currentPrice * item.quantity)
   );
  }

  void updateQuantity(int index, int quantity){
    final currentItem = _cartItems[index];

    _cartItems[index] = CartItemModel(
      quantity: quantity,
        product: currentItem.product
    );
    notifyListeners();
  }

  final num deliveryCharge = 60;

  num get finalTotal => totalPrice + deliveryCharge;
}
