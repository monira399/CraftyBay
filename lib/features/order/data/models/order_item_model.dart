class OrderItemModel {
  final String id;
  final String productId;
  final String title;
  final List<String> photos;
  final num price;
  final num quantity;
  final String? color;
  final String? size;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.photos,
    required this.price,
    required this.quantity,
    this.color,
    this.size,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final product = Map<String, dynamic>.from(
      json['product'] ?? {},
    );

    final snapshot = Map<String, dynamic>.from(
      json['product_snapshot'] ?? {},
    );

    return OrderItemModel(
      id: json['_id'] ?? '',
      productId: product['_id'] ?? snapshot['_id'] ?? '',
      title: snapshot['title'] ?? product['title'] ?? '',
      photos: List<String>.from(product['photos'] ?? []),
      price: json['price'] ?? snapshot['current_price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      color: json['color'],
      size: json['size'],
    );
  }
}