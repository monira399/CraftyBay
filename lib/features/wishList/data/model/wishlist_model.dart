class WishlistItemModel {
  final String id;
  final String productId;
  final String title;
  final double price;
  final double oldPrice;
  final String imageUrl;

  const WishlistItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
  });

  factory WishlistItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final product =
        json['product'] as Map<String, dynamic>? ?? {};

    final photos = product['photos'] as List? ?? [];

    return WishlistItemModel(
      id: json['_id']?.toString() ?? '',
      productId: product['_id']?.toString() ?? '',
      title: product['title']?.toString() ?? '',
      price: (product['current_price'] as num?)?.toDouble() ?? 0,
      oldPrice: (product['regular_price'] as num?)?.toDouble() ?? 0,
      imageUrl: photos.isNotEmpty
          ? photos.first.toString()
          : '',
    );
  }
}