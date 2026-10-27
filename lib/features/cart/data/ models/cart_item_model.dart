import 'package:craftybay/features/product/data/models/product_model.dart';

class CartItemModel {
  final int quantity;
  final ProductModel product;

  CartItemModel({
    required this.quantity,
    required this.product
});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        quantity: json['quantity'],
        product: ProductModel.fromJson(json['product']),
    );
  }
}