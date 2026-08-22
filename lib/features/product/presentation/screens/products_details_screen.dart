import 'package:craftybay/features/cart/presentation/screens/increment_decrement_button.dart';
import 'package:craftybay/features/common/presentation/widgets/favourite_button.dart';
import 'package:craftybay/features/common/presentation/widgets/rating_view.dart';
import 'package:craftybay/features/product/widgets/color_picker.dart';
import 'package:craftybay/features/product/widgets/product_carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../widgets/size_picker.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key});

  static const String name = '/product-details';
  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                ProductCarouselSlider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('Nike Shoe ASK455 - New Edition 2026', style: textTheme.titleMedium,)),
                          IncrementDecrementButton(onChanged: (newValue){}),
                        ],
                      ),
                      Row(
                        children: [
                          RatingView(),
                          TextButton(onPressed: (){}, child: Text('Reviews')),
                          FavouriteButton()
                        ],
                      ),
                      Text('Color', style: textTheme.titleMedium,),
                      ColorPicker(colors: ['Black', 'White', 'Red'], onChange: (selectedColor) {  },),
                      SizedBox(height: 16,),
                      Text('Color', style: textTheme.titleMedium,),
                      SizePicker(sizes: ['S', 'M', 'L', 'XL', 'XXL'], onChange: (selectedSize) {  },),
                      SizedBox(height: 16,),
                      Text('Description', style: textTheme.titleMedium,),
                      SizedBox(height: 8),
                      Text(
                        'A product description is marketing text that explains what an item is, how it works, and why a customer should buy it. It highlights key features, solves user problems, and helps build trust to drive sales. You can also use online tools like the Ahrefs AI Content Helper to draft these quickly.',
                      style: TextStyle(
                        color: Colors.grey
                      ),
                      )

                    ],
                  ),
                )
              ],
            ),
          )),

          _buildPriceAndAddToCartSection(textTheme)
        ],
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withAlpha(48),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: textTheme.bodyLarge),
              Text(
                '${Constants.takaSign}500',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
              width:120 ,
              child: FilledButton(onPressed: () {}, child: Text('Add to cart'))),
        ],
      ),
    );
  }
}
