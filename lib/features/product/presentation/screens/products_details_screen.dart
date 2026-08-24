import 'package:craftybay/features/auth/presentation/providers/auth_controllers.dart';
import 'package:craftybay/features/auth/presentation/screens/sign_In_screen.dart';
import 'package:craftybay/features/cart/presentation/screens/increment_decrement_button.dart';
import 'package:craftybay/features/common/presentation/providers/add_to_cart_provider.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/common/presentation/widgets/favourite_button.dart';
import 'package:craftybay/features/common/presentation/widgets/rating_view.dart';
import 'package:craftybay/features/common/presentation/widgets/snack_bar_message.dart';
import 'package:craftybay/features/product/providers/product_details_provider.dart';
import 'package:craftybay/features/product/widgets/color_picker.dart';
import 'package:craftybay/features/product/widgets/product_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';
import '../../widgets/size_picker.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();

  final AddToCartProvider _addToCartProvider = AddToCartProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productDetailsProvider.getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => _productDetailsProvider),
          ChangeNotifierProvider(create: (_) => _addToCartProvider),
        ],
        child: Column(
          children: [
            Consumer<ProductDetailsProvider>(
              builder: (context, _, _) {
                if (_productDetailsProvider.getProductDetailsInProgress) {
                  return CenterCircularProgress();
                }
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      children: [
                        ProductCarouselSlider(
                          imageUrls:
                              _productDetailsProvider
                                  .productDetailsModel
                                  ?.photos ??
                              [],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _productDetailsProvider
                                              .productDetailsModel
                                              ?.title ??
                                          '',
                                      style: textTheme.titleMedium,
                                    ),
                                  ),
                                  IncrementDecrementButton(
                                    maxValue: _productDetailsProvider.productDetailsModel?.quantity ?? 20,
                                    onChanged: (newValue) {},
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RatingView(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Reviews'),
                                  ),
                                  FavouriteButton(),
                                ],
                              ),
                              if (_productDetailsProvider
                                      .productDetailsModel
                                      ?.colors
                                      .isNotEmpty ??
                                  false)
                                Text('Color', style: textTheme.titleMedium),
                              ColorPicker(
                                colors:
                                    _productDetailsProvider
                                        .productDetailsModel
                                        ?.colors ??
                                    [],
                                onChange: (selectedColor) {},
                              ),
                              SizedBox(height: 16),
                              if (_productDetailsProvider
                                      .productDetailsModel
                                      ?.sizes
                                      .isNotEmpty ??
                                  false)
                                Text('Size', style: textTheme.titleMedium),
                              SizePicker(
                                sizes:
                                    _productDetailsProvider
                                        .productDetailsModel
                                        ?.sizes ??
                                    [],
                                onChange: (selectedSize) {},
                              ),
                              SizedBox(height: 16),
                              Text('Description', style: textTheme.titleMedium),
                              SizedBox(height: 8),
                              Text(
                                _productDetailsProvider
                                        .productDetailsModel
                                        ?.description ??
                                    '',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            _buildPriceAndAddToCartSection(textTheme),
          ],
        ),
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
                '${Constants.takaSign}${_productDetailsProvider.productDetailsModel?.price ?? ''}',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
        SizedBox(
          width: 120,
          child: Consumer<AddToCartProvider>(
            builder: (context, provider, _) {
              if (provider.addToCartInProgress) {
                return CenterCircularProgress();
              }

              return FilledButton(
                onPressed: _onTapAddToCartButton,
                child: Text('Add to cart'),
              );
            },
          ),
        )

        ],
      ),
    );
  }

  void _onTapAddToCartButton() async {
    if (await AuthController.isAlreadyLoggedIn()) {
     final bool isSuccess = await _addToCartProvider.addToCart(widget.productId);
     if(isSuccess){
       showSnackBarMessage(context, 'Added to cart!');
     } else {
       showSnackBarMessage(context, _addToCartProvider.errorMessage!);
     }
    } else {
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }

}
