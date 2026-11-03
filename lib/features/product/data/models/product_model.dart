class ProductModel {
  final String id;
  final String title;
  final String photo;
  final num currentPrice;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.photo,
    required this.currentPrice,
    required this.createdAt
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'].toString(),
      title: json['title'].toString(),
      photo: (json['photos'] as List?)?.isNotEmpty == true
          ? json['photos'][0].toString()
          : '',
      currentPrice: json['current_price'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
