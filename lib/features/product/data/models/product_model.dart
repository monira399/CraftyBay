
class ProductModel {
  final String id;
  final String title;
  final String photo;
  final String currentPrice;

  ProductModel({
    required this.id,
    required this.title,
    required this.photo,
    required this.currentPrice
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
    id: json['_id'].toString(),
    title: json['title'].toString(),
      photo: (json['photo'] as List?)?.isNotEmpty == true
          ? json['photo'][0].toString()
          : '',    //TODO find a better solution to handle null or empty list
    currentPrice: json['current_price']?.toString() ?? '',
  );
  }
}