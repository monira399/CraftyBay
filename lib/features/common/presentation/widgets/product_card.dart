
import 'package:craftybay/features/common/presentation/widgets/rating_view.dart';
import 'package:craftybay/features/product/data/models/product_model.dart';
import 'package:craftybay/features/product/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import 'favourite_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productModel,
    this.isGrid = false,
    required this.onFavouriteTap,
  });

  final ProductModel productModel;
  final bool isGrid;
  final VoidCallback onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 2,
        shadowColor: AppColors.themeColor.withAlpha(45),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProductsDetailsScreen.name,
                  arguments: productModel.id,
                );
              },
              child: Container(
                width: double.infinity,
                height: isGrid ? 85 : 105,
                color: AppColors.themeColor.withAlpha(30),
                child: Image.network(
                  productModel.photo,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Product Information
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}${productModel.currentPrice}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      RatingView(),
                    ],
                  ),

                  const SizedBox(height: 2),

                  Align(
                    alignment: Alignment.centerRight,
                    child: FavouriteButton(
                      onTap: onFavouriteTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
