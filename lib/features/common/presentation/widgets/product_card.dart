import 'package:craftybay/features/common/presentation/widgets/rating_view.dart';
import 'package:craftybay/features/product/data/models/product_model.dart';
import 'package:craftybay/features/product/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import 'favourite_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.productModel,
  });
  
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 3,
        shadowColor: AppColors.themeColor.withAlpha(45),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          spacing: 8,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ProductsDetailsScreen.name, arguments: productModel.id);
              },
              child: Container(
                width: 160,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: AppColors.themeColor.withAlpha(30),
                  image: DecorationImage(
                    image: NetworkImage(productModel.photo,
                    ), fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                   productModel.title,
                    maxLines: 1, style: TextStyle(
                        overflow: TextOverflow.ellipsis
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${Constants.takaSign}${productModel.currentPrice}', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor
                      ),),
                      RatingView(),
                      FavouriteButton(),
                    ],
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



