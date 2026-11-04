import '../../../auth/data/models/user_model.dart';
import 'shipping_address_model.dart';

class OrderModel {
  final String id;
  final String? transactionId;
  final UserModel user;
  final ShippingAddressModel shippingAddress;
  final num totalPrice;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int totalItems;

  OrderModel({
    required this.id,
    required this.transactionId,
    required this.user,
    required this.shippingAddress,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.totalItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      transactionId: json['tran_id'],
      user: UserModel.fromJson(
        Map<String, dynamic>.from(json['user'] ?? {}),
      ),
      shippingAddress: ShippingAddressModel.fromJson(
        Map<String, dynamic>.from(
          json['shipping_address'] ?? {},
        ),
      ),
      totalPrice: json['total_price'] ?? 0,
      status: json['status'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      totalItems: json['total_items'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'tran_id': transactionId,
      'user': user.toJson(),
      'shipping_address': shippingAddress.toJson(),
      'total_price': totalPrice,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'total_items': totalItems,
    };
  }
}